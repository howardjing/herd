import java.util.Random;

public class HermetianMatrixGenerator extends SparseMatrixGenerator{

    // given a number of pages n, 
    // return a hermetian sparse matrix listing the links of each page
    public HermetianMatrixGenerator(int n, double prob) {
        matrix = new int[n][n];
        this.prob = prob/2;
        
        Random rand = new Random();
        for (int i=0; i<n; i++) {
            for (int j=i; j<n; j++) {
                double chance = rand.nextDouble();
                if (chance < this.prob) {
                    matrix[i][j] = 1;
					matrix[j][i] = 1;
                }
            }
        }
        
    }
    
    public static void main(String[] args) {
        if (args.length != 2) {
            System.out.println("usage: java SparseMatrixGenerator [matrix dimension] [probability of being one]\n ie java SparseMatrixGenerator 100 0.05");
        }
        else {
            int dimension = Integer.parseInt(args[0]);
            double prob = Double.parseDouble(args[1]);
            HermetianMatrixGenerator me = new HermetianMatrixGenerator(dimension, prob);
            
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