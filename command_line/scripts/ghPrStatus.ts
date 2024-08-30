/**
 * Show all pull requests that are in review, in progress and review requested
 */
import { parseArgs } from "node:util";
import {
	type Format,
	type PR,
	getInProgressPrs,
	getInReviewPrs,
	getMyReviewRequestedPrs,
	printMyPr,
	printMyReviewRequestedPrs,
	printRows,
	printTableHeader,
	validFormats,
} from "./shared";

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
	categoryLabel: "In Review"
})

console.log("");

const inProgressPrs = await getInProgressPrs();
printMyPr({
	prs: inProgressPrs,
	format: values.format,
	categoryLabel: "In Progress"
})

console.log("");

const myReviewRequestedPrs = await getMyReviewRequestedPrs({ requiredLabel: 'frontend'});
printMyReviewRequestedPrs(myReviewRequestedPrs, values.format)

// When using the journal format, links to the pull requests and projects
// can be added all at the end instead of inline, which makes the tables
// much more concise and readable while still containing links.
if (values.format === "journal") {
	console.log("");
	printRows(
		myReviewRequestedPrs,
		(pr) => `[PR#${pr.data.number}]: ${pr.data.url}`,
	);
	printRows(inProgressPrs, (pr) => `[PR#${pr.data.number}]: ${pr.data.url}`);
	printRows(inReviewPrs, (pr) => `[PR#${pr.data.number}]: ${pr.data.url}`);

	let allPrs: PR[] = [];
	allPrs = allPrs.concat(inReviewPrs);
	allPrs = allPrs.concat(inProgressPrs);
	allPrs = allPrs.concat(myReviewRequestedPrs);

	const repos = {};
	for (const pr of allPrs) {
		repos[pr.data.repository.name] = pr.repoUrl;
	}
	for (const [repoName, repoUrl] of Object.entries(repos)) {
		console.log(`[${repoName}]: ${repoUrl}`);
	}
}
