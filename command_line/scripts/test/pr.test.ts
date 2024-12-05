import { expect, test, describe } from "bun:test";
import { prDataMock } from "./mocks";
import { PR } from "../shared/pr";

describe("PR class", () => {
	const pr = new PR({
		...prDataMock,
		body: "Resolves [#ABC-123](https://fre365.atlassian.net/browse/ABC-123)",
	});

	describe("issue capturing", () => {
		test("name", () => {
			expect(pr.issueName).toEqual("#ABC-123");
		});

		test("url", () => {
			expect(pr.issueUrl).toEqual(
				"https://fre365.atlassian.net/browse/ABC-123",
			);
		});
	});

	test("repoUrl", () => {
		expect(pr.repoUrl).toEqual("https://github.com/domain/repositoryName");
	});

	test("hasLabel", () => {
		expect(pr.hasLabel("test")).toEqual(false);
		expect(pr.hasLabel("documentation")).toEqual(true);
	});

	test("markdownIssueLink", () => {
		expect(pr.markdownIssueLink("inline")).toEqual(
			"[#ABC-123](https://fre365.atlassian.net/browse/ABC-123)",
		);
		expect(pr.markdownIssueLink("reference")).toEqual("[#ABC-123]");
		expect(pr.markdownIssueLink("reference-source")).toEqual(
			"[#ABC-123]: https://fre365.atlassian.net/browse/ABC-123",
		);
	});

	test("markdownPrLink", () => {
		expect(pr.markdownPrLink("inline")).toEqual(
			"[PR#143](https://github.com/domain/repositoryName/pull/143)",
		);
		expect(pr.markdownPrLink("reference")).toEqual("[PR#143]");
		expect(pr.markdownPrLink("reference-source")).toEqual(
			"[PR#143]: https://github.com/domain/repositoryName/pull/143",
		);
	});

	test("closedAtDate", () => {
		expect(pr.closedAtDate).toEqual("2024-10-10");
	});
});
