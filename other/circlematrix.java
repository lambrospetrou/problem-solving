import java.util.Arrays;

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
        Point prev, cur;
        int n, dirX = 1, dirY = 0, currentCircle = 0;

        // this determines if the next step of X or Y should increment,
        // decrement or stay the same based on the dirX or dirY.
        // it simulates the clockwise order - spiral order
        int dirs[] = new int[]{0,1,0,-1};

        public PointCalc(int N) {
            this.n = N;
            prev = new Point();
            cur = new Point();
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
            cur.x = prev.x;
            cur.y = prev.y;
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
            return cur;
        }
    }

    /**
     * Entry function that takes the N size of matrix row and returns a
     * matrix with the values in spiral increasing order.
     */
    public static int[][] solve(int N) {
        PointCalc pc = new PointCalc(N);
        int NN[][] = new int[N][N];
        Point p;
        for (int i=0; i<N*N; i++) {
            p = pc.next();
            NN[p.y][p.x] = i;
        }
        return NN;
    }

    ////////////// END OF SOLUTION 1 ///////////////

    ///////////// SOLUTION 2 ///////////////////

    static enum Side {
        Top, Right, Down, Left
    }

    public static void stepRight(Side side, Point c) {
        switch (side) {
            case Top:
                // top side - go down
                c.y += 1;
                break;
            case Right:
                // right side - go left
                c.x -= 1;
                break;
            case Down:
                // down side - go up
                c.y -= 1;
                break;
            case Left:
                // left side - go right
                c.x += 1;
                break;
        }
    }

    public static Side findSide(int x, int y, int currentCircle, int N) {
        // top side
        if (y == currentCircle) {
            return Side.Top;
        }
        // right side
        if (x == N - currentCircle - 1) {
            return Side.Right;
        }
        // bottom side
        if (y == N-currentCircle - 1) {
            return Side.Down;
        }
        // left side
        return Side.Left;
    }

    public static int[][] solve2(int N) {
        int NN[][] = new int[N][N];
        for (int i =0; i<N; i++) {
            Arrays.fill(NN[i], -1);
        }
        int counter = 0;
        Point c = new Point();
        int total = N*N;
        int currentCircle = 0;
        while(counter < total) {
            NN[c.y][c.x] = counter;
            counter++;
            // find the side we are
            Side side = findSide(c.x, c.y, currentCircle, N);
            switch (side) {
                case Top:
                    // top side - try go right
                    if (c.x+1 < N - currentCircle) {
                        c.x = c.x + 1;
                        continue;
                    }
                case Right:
                    // right side - try go down
                    if (c.y + 1 < N - currentCircle) {
                        c.y = c.y + 1;
                        continue;
                    }
                case Down:
                    // down side - try go left
                    if (c.x - 1 >= currentCircle ) {
                        c.x = c.x -  1;
                        continue;
                    }
                case Left:
                    // left side - try go up
                    if (c.y - 1 > currentCircle) {
                        c.y = c.y -  1;
                        continue;
                    } else {
                        currentCircle++;
                    }
            }
            stepRight(side, c);
        }
        return NN;
    }

    ///////////// END OF SOLUTION 2 ///////////////////////

    /**
     * This is just to test the solution.
     * @param args
     */
    public static void main (String[] args) {
        int N = 4;

        long start = System.nanoTime();
        int[][] NN = solve(N);
        long end = System.nanoTime();

        long start2 = System.nanoTime();
        int[][] NN2 = solve2(N);
        long end2 = System.nanoTime();

        System.out.printf("A:%d B:%d\n", (end-start), (end2-start2));

        for (int i=0; i<N; i++) {
            for (int j=0; j<N; j++) {
                System.out.print(NN[i][j] + " ");
            }
            System.out.println();
        }

        for (int i=0; i<N; i++) {
            for (int j=0; j<N; j++) {
                System.out.print(NN2[i][j] + " ");
            }
            System.out.println();
        }

    }
}