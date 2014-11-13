/**
 * "Write a function that for a given Integer N > 0, prints a matrix N x N
 * size whom the values are increasing in a spiral order."
 *  e.g N = 4
 * 	1  2  3  4
 * 	12 13 14 5
 * 	11 16 15 6
 * 	10 9  8  7
 *
 */
public class circlematrix {

    public static class Point {
        public Point() {
            x = 0; y = 0;
        }
        public Point(int x, int y) {
            this.x = x; this.y = y;
        }
        public int x,y;
    }

    /**
     * Calculates the next position on the matrix that we should put a number.
     * It is like an iterator that moves in spiral order starting from 0,0.
     */
    public static class PointCalc {
        Point prev;
        int n, dirX = 1, dirY = 0, currentCircle = 0;

        // this determines if the next step of X or Y should increment,
        // decrement or stay the same based on the dirX or dirY.
        // it simulates the clockwise order - spiral order
        int dirs[] = new int[]{0,1,0,-1};

        public PointCalc(int N) {
            this.n = N;
            prev = new Point();
        }

        boolean isInValidCell (int x, int y) {
            // we are at the right or bottom edge
            return x == currentCircle + n || y == currentCircle + n
                    // we are at the left or top edge
                    || y < currentCircle || x < currentCircle;
        }

        boolean isAtOrigin(int x, int y) {
            return x == y && y == currentCircle;
        }

        /**
         * Returns the next position of the spiral iteration.
         * The invariant of the function is that before the invocation
         * Point prev holds the next position to return.
         * After invocation the Point prev holds the position for the next call.
         */
        Point next() {
            Point p = new Point(prev.x, prev.y);
            // if this is the last one of the current circle
            //  move to the next circle inside the spiral
            // we check if the cell above the current one is the origin
            if (isAtOrigin(prev.x, prev.y-1)) {
                n -= 2;
                currentCircle++;
                prev.x = currentCircle;
                prev.y = currentCircle;
            } else {
                // check if we have a valid cell by forwarding
                if (isInValidCell(prev.x + dirs[dirX], prev.y + dirs[dirY])) {
                    // next direction
                    dirX = (dirX + 1) % dirs.length;
                    dirY = (dirY + 1) % dirs.length;
                }
                prev.x = prev.x + dirs[dirX];
                prev.y = prev.y + dirs[dirY];
            }
            return p;
        }
    }

    /**
     * Entry function that takes the N size of matrix row and returns a
     * matrix with the values in spiral increasing order.
     */
    public static int[][] solve(int N) {
        PointCalc pc = new PointCalc(N);
        int NN[][] = new int[N][N];
        for (int i=0; i<N*N; i++) {
            Point p = pc.next();
            NN[p.y][p.x] = i;
        }
        return NN;
    }

    /**
     * This is just to test the solution.
     * @param args
     */
    public static void main (String[] args) {
        int N = 5;
        int[][] NN = solve(N);

        for (int i=0; i<N; i++) {
            for (int j=0; j<N; j++) {
                System.out.print(NN[i][j] + " ");
            }
            System.out.println();
        }
    }
}