import { $ } from "bun";
import { PR } from "./pr";

const prFields = [
	"author",
	"body",
	"closedAt",
	"isDraft",
	"labels",
	"number",
	"repository",
	"title",
	"url",
] as const;

/** Get all pull requests that are in review (not a draft) */
export async function getInReviewPrs() {
	const flags = [
		"--state=open",
		"--assignee=@me",
		`--json ${prFields.join(",")}`,
	].join(" ");

	const input = await $`gh search prs ${{ raw: flags }}`.text();
	const prs: PR[] = JSON.parse(input).map((pr) => new PR(pr));
	return prs.filter((pr) => !pr.isDraft);
}

/** Get all pull requests that have been merged */
export async function getMergedPrs(date?: string) {
	const updatedDate = date || (await $`date +%Y-%m`.text()).trim();
	const flags = [
		"--assignee=@me",
		`--json ${prFields.join(",")}`,
		`--updated "${updatedDate}"`,
		"--merged",
	].join(" ");

	const input = await $`gh search prs ${{ raw: flags }}"`.text();
	const prs: PR[] = JSON.parse(input).map((pr) => new PR(pr));
	return prs;
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
	return prs.filter((pr) => pr.isDraft);
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

export async function getReviewedPrs(date?: string) {
	const updatedDate = date || (await $`date +%Y-%m`.text()).trim();
	const flags = [
		"--reviewed-by=@me",
		`--json ${prFields.join(",")}`,
		`--updated "${updatedDate}"`,
		// gh counts opened by me as also reviewed by me, and I want to only
		// see pull requests where I reviewed someone else's code.
		"-- -author:ConnorChristensen",
	].join(" ");

	const input = await $`gh search prs ${{ raw: flags }}"`.text();
	const prs: PR[] = JSON.parse(input).map((pr) => new PR(pr));
	return prs;
}
