import { $ } from "bun";
import { parseArgs } from "node:util";
import { PR, prFields, printRows, printTableHeader } from "./shared";

const { values } = parseArgs({
	args: Bun.argv,
	options: {
		glow: {
			type: "boolean",
		},
		// format YYYY-MM
		date: {
			type: "string",
		},
	},
	strict: true,
	allowPositionals: true,
});

const updatedDate = values.date || (await $`date +%Y-%m`.text()).trim();
const flags = [
	"--reviewed-by=@me",
	`--json ${prFields.join(",")}`,
	`--updated "${updatedDate}"`,
	// gh counts opened by me as also reviewed by me, and I want to only
	// see pull requests where I reviewed someone else's code.
	"-- -author:ConnorChristensen",
].join(" ");

const input = await $`gh search prs ${{ raw: flags }}"`.text();
const prs: PR[] = JSON.parse(input).map(pr => new PR(pr));

if (!values.glow) {
	printTableHeader("Reviewed", ["PR ", "Project", "Author", "Description"]);
	printRows(
		prs,
		(pr) =>
			`| [PR#${pr.data.number}](${pr.data.url}) | [${pr.data.repository.name}] | [${pr.authorName}](${pr.data.author.url}) | ${pr.data.title} |`,
	);
} else {
	console.log("## Reviewed");
	printRows(
		prs,
		(pr) =>
			`* [${pr.data.title}](${pr.data.url}) ${pr.data.repository.name} ${pr.authorName}`,
	);
}
