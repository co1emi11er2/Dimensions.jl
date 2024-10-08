mutable struct RightDimensions{T, S}
    xs::Vector{T}
    ys::Vector{S}
    labels::Labels{T, S}
    minor_lines::Vector{S}
    major_lines::Vector{S}
end


function dim_right(xs::Vector{T}, ys::Vector{S}; offset=zero(S)) where {T, S}
    max_y = max(ys...)
    min_y = min(ys...)
    max_x = max(xs...)
    
    if offset == zero(S)
        offset = (max_y - min_y) * 0.1
    end
    
    x_dims = [max_x, max_x] .+ offset 
    y_dims = [max_y, min_y] 

    major_lines, minor_lines = get_major_minor_lines(y_dims, offset)

    labels = dimension_labels(x_dims, y_dims)

    if offset >= zero(S)
        return RightDimensions(x_dims, y_dims, labels, minor_lines, major_lines)
    else
        return LeftDimensions(x_dims, y_dims, labels, minor_lines, major_lines)
    end
end