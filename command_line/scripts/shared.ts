import { $ } from "bun";
import type { PullRequestType } from "./ghTypes";

export const validFormats = ["terminal", "journal"] as const;
export type Format = (typeof validFormats)[number];

export function printTableHeader(category: string, columns: string[]) {
	console.log(`### ${category}`);
	console.log("");
	console.log(`| ${columns.join(" | ")} |`);

	let tableHeaderColumns = "|";
	for (const column of columns) {
		tableHeaderColumns += " ";
		for (const chars of column) {
			tableHeaderColumns += "-";
		}
		tableHeaderColumns += " |";
	}
	console.log(tableHeaderColumns);
}

export function printRows<T>(prs: T[], formatter: (prs: T) => void) {
	for (const pr of prs) {
		console.log(formatter(pr));
	}
}

export const prFields = [
	"author",
	"body",
	"isDraft",
	"labels",
	"number",
	"repository",
	"title",
	"url",
] as const;

export class PR {
	data: PullRequestType;
	constructor(data: PullRequestType) {
		this.data = data;
	}
	print() {
		console.log(JSON.stringify(this.data));
	}
	get authorName() {
		return this.data.author.login;
	}
	get isBot() {
		return this.data.author.type === "Bot";
	}
	get issue() {
		const issue = this.data.body.match(
			/\[#.*?\]\(https:\/\/jira.funda.nl.*?\)/,
		);
		if (issue?.length) {
			return issue[0];
		}
		return "";
	}
	get repoUrl() {
		const matches = this.data.url.match(/^(.*?)\/pull\/.*/);
		if (matches?.length && matches.length > 1) {
			return matches[1];
		}
		return null;
	}
	hasLabel(name: string) {
		const labelNames = this.data.labels.map((label) => label.name);
		return labelNames.includes(name);
	}
}

/** Get all pull requests that are in review (not a draft) */
export async function getInReviewPrs() {
	const flags = [
		"--state=open",
		"--assignee=@me",
		`--json ${prFields.join(",")}`,
	].join(" ");

	const input = await $`gh search prs ${{ raw: flags }}`.text();
	const prs: PR[] = JSON.parse(input).map((pr) => new PR(pr));
	return prs.filter((pr) => !pr.data.isDraft);
}

/** Get all pull requests that are in progress (draft status) */
export async function getInProgressPrs() {
	const flags = [
		"--state=open",
		"--assignee=@me",
		`--json ${prFields.join(",")}`,
	].join(" ");

	const input = await $`gh search prs ${{ raw: flags }}`.text();
	const prs: PR[] = JSON.parse(input).map((pr) => new PR(pr));
	return prs.filter((pr) => pr.data.isDraft);
}

/**
 * Get all pull requests where my review has been requested. To filter out bots
 * and requests for review from a group of which you are a part of, any pull requests
 * that was opened by a bot or does not have a specific label are filtered out.
 * @param requiredLabel A github label that is required on the pull request to be shown
 **/
export async function getMyReviewRequestedPrs({
	requiredLabel,
}: { requiredLabel: string }): Promise<PR[]> {
	const flags = [
		`--json ${prFields.join(",")}`,
		"--state=open",
		"--review-requested=@me",
	].join(" ");

	const input = await $`gh search prs ${{ raw: flags }}`.text();
	return JSON.parse(input)
		.map((pr) => new PR(pr))
		.filter((pr: PR) => !pr.isBot && pr.hasLabel(requiredLabel));
}

export function printMyReviewRequestedPrs(prs: PR[], format: Format) {
	switch (format) {
		case "journal":
			printTableHeader("Review Requested", [
				"PR",
				"Project",
				"Author",
				"Description",
			]);
			printRows(
				prs,
				(pr) =>
					`| [PR#${pr.data.number}] | [${pr.data.repository.name}] | [${pr.authorName}](${pr.data.author.url}) | ${pr.data.title} |`,
			);
			break;

		case "terminal":
			console.log("## Review Requested");
			printRows(
				prs,
				(pr) => `* <${pr.data.url}>: ${pr.data.title}, ${pr.authorName}`,
			);
			break;
	}
}

interface PrintMyPrProps {
	prs: PR[];
	format: Format;
	categoryLabel: string;
}

export function printMyPr({ prs, format, categoryLabel }: PrintMyPrProps) {
	switch (format) {
		case "terminal":
			console.log(`## ${categoryLabel}`);
			printRows(prs, (pr) => `* <${pr.data.url}>: ${pr.data.title}`);
			break;

		case "journal":
			printTableHeader(categoryLabel, [
				"Issue",
				"PR",
				"Project",
				"Description",
			]);
			printRows(
				prs,
				(pr) =>
					`| ${pr.issue} | [PR#${pr.data.number}] | [${pr.data.repository.name}] | ${pr.data.title} |`,
			);
			break;
	}
}
