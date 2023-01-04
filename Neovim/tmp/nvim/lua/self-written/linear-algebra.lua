local function matrix_multiply(a, b)
    -- Check that the matrices are compatible for multiplication
    if #a[1] ~= #b then
        error("Incompatible matrices for multiplication")
    end

    -- Initialize the result matrix with zeros
    local result = {}
    for i = 1, #a do
        result[i] = {}
        for j = 1, #b[1] do
            result[i][j] = 0
        end
    end
    
    -- Perform the matrix multiplication
    for i = 1, #a do
        for j = 1, #b[1] do
            for k = 1, #a[1] do
                result[i][j] = result[i][j] + a[i][k] * b[k][j]
            end
        end
    end

    -- Return the result matrix
    return result
end

-- Function to input and display matrices
function matrix_multiply_interface(a, b)
    -- -- Input the matrices
    -- print("Enter matrix A:")
    -- local a = vim.fn.inputlist()
    -- print("Enter matrix B:")
    -- local b = vim.fn.inputlist()

    -- Perform the matrix multiplication
    local result = matrix_multiply(a, b)

    -- Display the result matrix
    l = "["
    for i = 1, #result do
        l = l .. "["
        for j = 1, (#result[1]-1) do
            l = l .. string.format("%d, ", result[i][j])
        end
        l = l .. string.format("%d]", result[i][#result[1]])
        if i ~= #result then 
            l = l .. ","
        else
            l = l .. "]"
        end
        print(l)
        l = ""
    end
    print()
end
