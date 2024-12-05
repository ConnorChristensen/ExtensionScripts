import type { PullRequestType } from "./ghTypes";
import type { MarkdownLinkFormat } from "./types";

function makeMarkdownLink(
	format: MarkdownLinkFormat,
	linkText: string,
	linkUrl: string,
) {
	switch (format) {
		case "inline":
			return `[${linkText}](${linkUrl})`;
		case "reference":
			return `[${linkText}]`;
		case "reference-source":
			return `[${linkText}]: ${linkUrl}`;
	}
}

export class PR {
	private data: PullRequestType;
	constructor(data: PullRequestType) {
		this.data = data;
	}
	print() {
		console.log(JSON.stringify(this.data));
	}
	get authorName() {
		return this.data.author.login;
	}
	get authorUrl() {
		return this.data.author.url;
	}
	get isBot() {
		return this.data.author.type === "Bot";
	}
	get isDraft() {
		return this.data.isDraft;
	}
	get title() {
		return this.data.title;
	}
	get number() {
		return this.data.number;
	}
	get repoName() {
		return this.data.repository.name;
	}
	get url() {
		return this.data.url;
	}
	get issueName() {
		const issue = this.data.body.match(
			/\[(#.*?)\]\(https:\/\/fre365.atlassian.net.*?\)/,
		);
		if (issue?.length && issue.length > 0) {
			return issue[1];
		}
		return "";
	}
	get issueUrl() {
		const issue = this.data.body.match(
			/\((https:\/\/fre365.atlassian.net.*?)\)/,
		);
		if (issue?.length && issue.length > 0) {
			return issue[1];
		}
		return "";
	}
	get repoUrl() {
		const matches = this.data.url.match(/^(.*?)\/pull\/.*/);
		if (matches?.length && matches.length > 1) {
			return matches[1];
		}
		throw Error("PR repo URL not found");
	}
	hasLabel(name: string) {
		const labelNames = this.data.labels.map((label) => label.name);
		return labelNames.includes(name);
	}

	markdownIssueLink(format: MarkdownLinkFormat) {
		if (!this.issueName) {
			return "";
		}
		return makeMarkdownLink(format, this.issueName, this.issueUrl);
	}

	markdownPrLink(format: MarkdownLinkFormat) {
		return makeMarkdownLink(
			format,
			`PR#${this.data.number.toString()}`,
			this.data.url,
		);
	}

	markdownRepoLink(format: MarkdownLinkFormat) {
		return makeMarkdownLink(format, this.data.repository.name, this.repoUrl);
	}

	markdownAuthorLink(format: MarkdownLinkFormat) {
		return makeMarkdownLink(format, this.authorName, this.authorUrl);
	}

	get closedAtDate() {
		return this.data.closedAt.split("T")[0];
	}
}
