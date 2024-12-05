/**
 * Show all pull requests that are in review, in progress and review requested
 */
import { parseArgs } from "node:util";
import { type Format, validFormats } from "./shared";
import {
	getInReviewPrs,
	getInProgressPrs,
	getMyReviewRequestedPrs,
} from "./shared/prGetters";
import { printMyPr, printMyReviewRequestedPrs } from "./shared/printers";
import type { PR } from "./shared/pr";

interface Args {
	format: Format;
	debug: boolean | undefined;
}

//////// get command line arguments ////////
const { values } = parseArgs({
	args: Bun.argv,
	options: {
		format: {
			type: "string",
		},
	},
	strict: true,
	allowPositionals: true,
});

//////// helper functions ////////
const argumentsAreValid = (local: typeof values): local is Args => {
	return validFormats.includes(local.format as Format);
};

if (!argumentsAreValid(values)) {
	console.log("Invalid or missing format. eg --format terminal");
	process.exit();
}

//////// fetch and print pull requests ////////
const inReviewPrs = await getInReviewPrs();
printMyPr({
	prs: inReviewPrs,
	format: values.format,
	categoryLabel: "In Review",
});

console.log("");

const inProgressPrs = await getInProgressPrs();
printMyPr({
	prs: inProgressPrs,
	format: values.format,
	categoryLabel: "In Progress",
});

console.log("");

const myReviewRequestedPrs = await getMyReviewRequestedPrs({
	requiredLabel: "frontend",
});
printMyReviewRequestedPrs(myReviewRequestedPrs, values.format);

// When using the journal format, links to the pull requests and projects
// can be added all at the end instead of inline, which makes the tables
// much more concise and readable while still containing links.
if (values.format === "journal") {
	console.log("");

	let allPrs: PR[] = [];
	allPrs = allPrs.concat(inReviewPrs);
	allPrs = allPrs.concat(inProgressPrs);
	allPrs = allPrs.concat(myReviewRequestedPrs);

	// sets will automatically prevent duplicate entries
	const links: Set<string> = new Set();
	for (const pr of allPrs) {
		links.add(`[${pr.repoName}]: ${pr.repoUrl}`);
		links.add(`[PR#${pr.number}]: ${pr.url}`);
		if (pr.issueName) {
			links.add(`[${pr.issueName}]: ${pr.issueUrl}`);
		}
	}

	for (const link of Array.from(links).toSorted()) {
		console.log(link);
	}
}
