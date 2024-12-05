import type { Format } from ".";
import type { PR } from "./pr";
import type { MarkdownLinkFormat } from "./types";

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

export function printRows<T>(prs: T[], formatter: (pr: T) => string) {
	for (const pr of prs) {
		console.log(formatter(pr));
	}
}

export function printTable<T>(
	name: string,
	prs: T[],
	columns: Array<[string, (pr: T) => string]>,
) {
	const headers: string[] = [];
	const formatters: Array<(pr: T) => string> = [];
	for (const column of columns) {
		headers.push(column[0]);
		formatters.push(column[1]);
	}
	printTableHeader(name, headers);
	for (const pr of prs) {
		const str = formatters.map((formatter) => formatter(pr));
		console.log(`| ${str.join(" | ")} |`);
	}
}

function outputFormatToMarkdownLinkFormat(
	outputFormat: Format,
): MarkdownLinkFormat {
	switch (outputFormat) {
		case "tasks":
			return "inline";
		case "journal":
			return "reference";
		default:
			return "inline";
	}
}

export function printMyReviewRequestedPrs(prs: PR[], format: Format) {
	if (format === "terminal") {
		console.log("## Review Requested");
		printRows(prs, (pr) => `* <${pr.url}>: ${pr.title}, ${pr.authorName}`);
		return;
	}

	const markdownLinkFormat = outputFormatToMarkdownLinkFormat(format);
	printTable("Review Requested", prs, [
		["PR", (pr) => pr.markdownPrLink(markdownLinkFormat)],
		["Project", (pr) => pr.markdownRepoLink(markdownLinkFormat)],
		["Author", (pr) => pr.markdownAuthorLink(markdownLinkFormat)],
		["Description", (pr) => pr.title],
	]);
}

interface PrintMyPrProps {
	prs: PR[];
	format: Format;
	categoryLabel: string;
}

export function printMyPr({ prs, format, categoryLabel }: PrintMyPrProps) {
	if (format === "terminal") {
		console.log(`## ${categoryLabel}`);
		printRows(prs, (pr) => `* <${pr.url}>: ${pr.title}`);
		return;
	}

	const markdownLinkFormat = outputFormatToMarkdownLinkFormat(format);
	printTable(categoryLabel, prs, [
		["Issue", (pr) => pr.markdownIssueLink(markdownLinkFormat)],
		["PR", (pr) => pr.markdownPrLink(markdownLinkFormat)],
		["Project", (pr) => pr.markdownRepoLink(markdownLinkFormat)],
		["Description", (pr) => pr.title],
	]);
}
