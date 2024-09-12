import type { PullRequestType } from "../ghTypes";

export const prDataMock: PullRequestType = {
	author: {
		id: "MDQ6VXNlcjkxNTg1MTc=",
		is_bot: false,
		login: "ConnorChristensen",
		type: "User",
		url: "https://github.com/ConnorChristensen",
	},
	body: "Resolves [#ABC-123](https://jira.funda.nl/browse/ABC-123).",
	isDraft: false,
	labels: [
		{
			color: "0075ca",
			description: "Improvements or additions to documentation",
			id: "LA_kwDOLfIZu88AAAABjivTsQ",
			name: "documentation",
		},
	],
	number: 143,
	repository: {
		name: "repositoryName",
		nameWithOwner: "domain/repositoryName",
	},
	title: "Add external documentation for interactivity",
	url: "https://github.com/domain/repositoryName/pull/143",
};
