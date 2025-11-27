/**
 * Get pull requests to be added to the tasks list for the month.
 */
import { parseArgs } from "node:util";
import { getMergedPrs, getReviewedPrs } from "./shared/prGetters";
import { printTable } from "./shared/printers";
import type { MarkdownLinkFormat } from "./shared/types";

//////// get command line arguments ////////
const { values } = parseArgs({
	args: Bun.argv,
	options: {
		// format YYYY-MM
		date: {
			type: "string",
		},
		help: {
			type: 'boolean',
			short: 'h'
		}
	},
	strict: true,
	allowPositionals: true,
});

if (values.help) {
	console.log(`
Show tasks for a particular month. If no date is supplied, the response
defaults to the current month.

Usage:
	bun ./ghPrTasks.ts
	gh-tasks
	gh-tasks --date 2024-10
	gh-tasks -h | --help

Options:
	-h --help     Show this screen.
	--date        View tasks from a particular month.
	`)
	process.exit(0)
}

//////// fetch and print pull requests ////////
const markdownLinkFormat: MarkdownLinkFormat = "inline";

printTable("Merged", await getMergedPrs(values.date), [
	["Issue", (pr) => pr.markdownIssueLink(markdownLinkFormat)],
	["PR", (pr) => pr.markdownPrLink(markdownLinkFormat)],
	["Project", (pr) => pr.markdownRepoLink(markdownLinkFormat)],
	["Description", (pr) => pr.title],
	["Merged Date", (pr) => pr.closedAtDate],
]);

console.log("");

printTable("Reviewed", await getReviewedPrs(values.date), [
	["PR", (pr) => pr.markdownPrLink(markdownLinkFormat)],
	["Project", (pr) => pr.markdownRepoLink(markdownLinkFormat)],
	["Author", (pr) => pr.markdownAuthorLink(markdownLinkFormat)],
	["Description", (pr) => pr.title],
	["Closed", (pr) => pr.closedAtDate],
]);
