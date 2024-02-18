import { LengthRequired } from "@tsed/exceptions";
import exp from "constants";
import { resourceLimits } from "worker_threads";

export function elementMult(a: number[][], b: number[][]){
    let result = new Array(a.length).fill(0).map(() => new Array(a[0].length).fill(0));
    for(let i = 0; i<a.length; i++){
        for(let j=0 ; j< a[0].length; j++){
            result[i][j] = a[i][j] * b[i][j];
        }
    }
    return result;
}

export function elementDiv(a: number[][], b: number[][]){
    let result = new Array(a.length).fill(0).map(() => new Array(a[0].length).fill(0));
    for(let i = 0; i<a.length; i++){
        for(let j=0 ; j< a[0].length; j++){
            result[i][j] = a[i][j] / b[i][j];
        }
    }
    return result;
}

export function transpose(matrix: number[][]){
    let m = matrix.length;
    let n = matrix[0].length;
    let result = new Array(n).fill(0).map(() => new Array(m).fill(0));
    for(let i=0; i<n; i++){
        for(let j=0; j<m; j++){
            result[i][j] = matrix[j][i];
        }
    }
    return result;
}

export function matrixMultiply(a: number[][], b: number[][]){
    let m = a.length;
    let n = b[0].length;
    let p = b.length;

    if (a[0].length !== p){
        throw new Error("Incompatible matrix dimensions");
    }
    let result = new Array(m).fill(0).map(() => new Array(n).fill(0));
    for(let i=0;  i<m; i++){
        for(let j=0; j< n; j++){
            result[i][j] = 0;
            for(let k=0; k<p; k++){
                let product = a[i][k] * b[k][j];
                result[i][j] += product;
            }
        }
    }
    return result;
}

export function personSimilarity(user1: number[], user2: number[]): number{
    let sum25q = 0;
    let pSum = 0;
    let n = 0;
    let sum15q = 0;
    let sum1 = 0;
    let sum2 = 0;

    for(let i =0; i<user1.length; i++){
        if(user1[i] != null && user2[i] != null){
            n++;
            sum1 += user1[i];
            sum2 += user2[i];
            sum15q += user1[i] * user1[i];
            sum25q += user2[i] * user2[i];
            pSum += user1[i] * user2[i]
        }
    }

    if(n == 0){
        return 0;
    }

    let num = pSum - (sum1 * sum2 / n);
    let den = Math.sqrt((sum15q - sum1 * sum2 / n) * (sum25q - sum1 * sum2 / n));

    if(den == 0){
        return 0;
    }

    return num / den;
}