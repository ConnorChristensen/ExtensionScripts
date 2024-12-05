export interface PullRequestAuthor {
	id: string;
	is_bot: boolean;
	login: string;
	type: "User" | "Bot";
	url: string;
	labels?: string[];
}

export interface PullRequestRepository {
	name: string;
	nameWithOwner: string;
	url?: string;
}

export interface PullRequestLabel {
	color: string;
	description: string;
	id: string;
	name: string;
}

export interface PullRequestAssignee {
	id: string;
	is_bot: boolean;
	login: string;
	type: string;
	url: string;
}

export interface PullRequestType {
	assignees?: PullRequestAssignee[];
	author: PullRequestAuthor;
	body: string;
	closedAt: string;
	isDraft: boolean;
	labels: PullRequestLabel[];
	number: number;
	repository: PullRequestRepository;
	title: string;
	url: string;
}
