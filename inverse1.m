function [ P3, P2 ] = inverse1( A, P )
    % We know that A is the orientation matrix of the total operation
    % and P is the position of the end-effort point
    
    % Extract the Y axis from the orientation matrix
    VectorX = A(2,1);
    VectorY = A(2,2);
    VectorZ = A(2,3);
    
    % construct and normalize the vector
    Vector = [VectorX; VectorY; VectorZ];
    Vector = Vector / norm(Vector);
    
    % Get the P3
    P3 = P - 130 * Vector; 
    
    % Now we get the 3 length of the triangle
    P1 = [0; 0; 190];
    LP1P3 = P3-P1;
    L13 = sqrt(sum(LP1P3.*LP1P3));
    L23 = 130; L12 = 200;
    
    % Get the angles
    cos1 = (L12^2 + L13^2 - L23^2)/(2*L12*L23);
    cos2 = (L12^2 + L23^2 - L13^2)/(2*L12*L23);
    cos3 = (L13^2 + L23^2 - L12^2)/(2*L13*L23);
    
    P2 = [P2x; P2y; P2z];
    LP2P3 = P2-P3;
    LP1P2 = P1-P2;
    L23 = sqrt(sum())
end

