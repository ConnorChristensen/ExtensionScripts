export const validFormats = ["terminal", "journal", "tasks"] as const;
export type Format = (typeof validFormats)[number];
