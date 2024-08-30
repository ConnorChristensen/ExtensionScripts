import { parseArgs } from "node:util";
import { type Format, getMyReviewRequestedPrs, printMyReviewRequestedPrs, validFormats } from "./shared";

interface Args {
	format: Format;
	debug: boolean | undefined;
}

const { values } = parseArgs({
	args: Bun.argv,
	options: {
		format: {
			type: "string",
		},
		debug: {
			type: "boolean",
		},
	},
	strict: true,
	allowPositionals: true,
});

const argumentsAreValid = (local: typeof values): local is Args => {
	return validFormats.includes(local.format as Format);
};

if (!argumentsAreValid(values)) {
	console.log("Invalid or missing format. eg --format terminal");
	process.exit();
}

const prs = await getMyReviewRequestedPrs({ requiredLabel: 'frontend' });
printMyReviewRequestedPrs(prs, values.format)
