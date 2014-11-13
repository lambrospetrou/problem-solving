/**
 * "Write a function that prints a matrix N x N size and the values are increasing in a spiral order."
 * 	1  2  3  4
 * 	12 13 14 5
 * 	11 16 15 6
 * 	10 9  8  7
 *
 */
public class circlematrix {

    public static class Point {
        public int x,y;
    }

    public static class PointCalc {
        Point p;
        int N;
        int currentCircle = 0;
        int currentCircleMoves = 0;

        int dirs[] = new int[]{0,1,0,-1};

        int dirX = 1;
        int dirY = 0;

        public PointCalc(int N) {
            this.N = N;
            p = new Point();
            p.x = -1;
            p.y = 0;
        }

        // calculate the next position
        Point next() {
            if (currentCircleMoves == (2*N + 2*(N-2))) {
                currentCircleMoves = 0;
                N -= 2;
                currentCircle++;
                p.x = currentCircle - 1;
                p.y = currentCircle;
            }
            currentCircleMoves++;
            // check if we have a valid cell by forwarding
            if ( (p.x + dirs[dirX]) == currentCircle + N || (p.y + dirs[dirY]) == currentCircle +  N
                    || (p.x + dirs[dirX]) < currentCircle || (p.y + dirs[dirY]) < currentCircle ) {
                // next rotation
                dirX = (dirX + 1) % dirs.length;
                dirY = (dirY + 1) % dirs.length;
            }
            p.x = p.x + dirs[dirX];
            p.y = p.y + dirs[dirY];
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