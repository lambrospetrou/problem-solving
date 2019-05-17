import {hello} from "./hello";

it("should return hello", () => {
    expect(hello()).toEqual("hello, world!");
});

