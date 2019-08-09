import { deepestNode } from "./problem-80"

it("should return 'd'", () => {
  const tree = {
    left: {
      left: {
        value: 'd'
      },
      value: 'b'
    },
    right: {
      value: 'c',
      left: {
        value: 'e',
        right: {
          value: 'f',
          left: {
            value: 'h'
          }
        },
        left: {
          value: 'g'
        }
      }
    },
    value: 'a'
  };

  expect(deepestNode(tree).value).toEqual('h');
  expect(deepestNode(tree.left).value).toEqual('d');
  expect(deepestNode(tree.right).value).toEqual('h');
});

it('should return the root if no children', () => {
  expect(deepestNode({value: 'a'}).value).toEqual('a');
});
