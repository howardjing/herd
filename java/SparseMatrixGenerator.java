import java.util.Random;

public class SparseMatrixGenerator {

    int[][] matrix;
    double prob;
    
    // given a number of pages n, 
    // return a sparse matrix listing the links of each page
    public SparseMatrixGenerator(int n, double prob) {
        
        matrix = new int[n][n];
        this.prob = prob;
        
        Random rand = new Random();
        for (int i=0; i<n; i++) {
            for (int j=0; j<n; j++) {
                double chance = rand.nextDouble();
                if (chance < this.prob) {
                    matrix[i][j] = 1;
                }
            }
        }
        
    }
    
    // prints the sparse matrix in CSV format
    // ugh string concatenation sucks
    public String toString() {
        String s = "";
        for (int i=0; i<matrix.length; i++) {
            for (int j=0; j<matrix[i].length; j++) {
                s = s + matrix[i][j] + ",";
            } 
            s = s.substring(0,s.length() - 1) + "\n";
        }
        return s;
    }
    
    public static void main(String[] args) {
        if (args.length != 2) {
            System.out.println("usage: java SparseMatrixGenerator [matrix dimension] [probability of being one]\n ie java SparseMatrixGenerator 100 0.05");
        }
        else {
            int dimension = Integer.parseInt(args[0]);
            double prob = Double.parseDouble(args[1]);
            SparseMatrixGenerator me = new SparseMatrixGenerator(dimension, prob);
            
            for (int i=0; i<me.matrix.length; i++) {
                String s = "";
                for (int j=0; j<me.matrix[i].length; j++) {
                    s = s + me.matrix[i][j] + ",";
                } 
                System.out.println(s.substring(0,s.length()-1));
            }
            
        }
        
    }
}