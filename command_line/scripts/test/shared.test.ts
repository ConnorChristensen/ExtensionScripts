import { expect, test, describe } from "bun:test";
import { PR } from "../shared";
import { prDataMock } from "./mocks";

describe("PR class", () => {
	describe("issue capturing", () => {
		const pr = new PR({
			...prDataMock,
			body: "Resolves [#ABC-123](https://jira.funda.nl/browse/ABC-123)",
		});

		test("name", () => {
			expect(pr.issueName).toEqual("#ABC-123");
		});

		test("url", () => {
			expect(pr.issueUrl).toEqual("https://jira.funda.nl/browse/ABC-123");
		});
	});
});
