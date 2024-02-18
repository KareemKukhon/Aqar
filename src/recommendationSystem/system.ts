import { matrixMultiply, transpose, elementMult, elementDiv } from "./operation";

function initializeMatrix(rows: number, cols: number): number[][] {
    return new Array(rows).fill(0).map(() => new Array(cols).fill(0).map(() => Math.floor(Math.random() + 1)));
}

function calculateError(product: number[][], original: number[][]): number {
    let error = 0;
    for (let i = 0; i < product.length; i++) {
        for (let j = 0; j < product[0].length; j++) {
            error += Math.sqrt(Math.pow(product[i][j] - original[i][j], 2));
        }
    }
    return error;
}

export function nonNegativeMatrixFactorization(dataMatrix: number[][], rank: number, maxIterations: number): number[][] {
    let basisMatrix = initializeMatrix(dataMatrix.length, rank);
    let coefficientMatrix = initializeMatrix(rank, dataMatrix[0].length);
    let maxError = 100000;
    let resultMatrix = initializeMatrix(dataMatrix.length, dataMatrix[0].length);
    let checkMatrix = initializeMatrix(dataMatrix.length, dataMatrix[0].length);

    for (let iteration = 0; iteration < maxIterations; iteration++) {
        let numeratorMatrix = matrixMultiply(transpose(basisMatrix), checkMatrix);
        let denominatorMatrix = matrixMultiply(matrixMultiply(basisMatrix, coefficientMatrix), transpose(coefficientMatrix));
        basisMatrix = elementMult(basisMatrix, elementDiv(numeratorMatrix, denominatorMatrix));

        let productMatrix = matrixMultiply(basisMatrix, coefficientMatrix);
        checkMatrix = matrixMultiply(basisMatrix, coefficientMatrix);

        for (let i = 0; i < checkMatrix.length; i++) {
            for (let j = 0; j < checkMatrix[0].length; j++) {
                if (dataMatrix[i][j] > 0) {
                    checkMatrix[i][j] = dataMatrix[i][j];
                }
            }
        }

        let currentError = calculateError(productMatrix, checkMatrix);

        if (currentError < maxError) {
            resultMatrix = productMatrix;
            maxError = currentError;
            if (currentError < 0.001) {
                break;
            }
        }
    }

    return resultMatrix;
}
