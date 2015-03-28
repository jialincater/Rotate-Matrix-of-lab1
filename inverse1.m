function [ ] = inverse1( A, P )
    % We know that A is the orientation matrix of the total operation
    % and P is the position of the end-effort point
    
    % Extract the Y axis from the orientation matrix
    VectorX = A(1,2);
    VectorY = A(2,2);
    VectorZ = A(3,2);
    
    % construct and normalize the vector
    Vector = [VectorX; VectorY; VectorZ];
    Vector = Vector / sqrt(sum(Vector.*Vector));
    
    % Get the P3
    P3 = P - 130 * Vector; 
    
    % Get zeta0, zeta1, zeta2!~ With clevery's algorithm
    [zeta0,zeta1,zeta2] = Inverse(P3(1),P3(2),P3(3));
    if zeta2 > 0
        zeta2 = -zeta2;
    end

    % Get the P2
    % Paras
    R01 = [cosd(zeta0),-sind(zeta0),0;sind(zeta0),cosd(zeta0),0;0,0,1];
    R12 = [1,0,0;0,cosd(zeta1),-sind(zeta1);0,sind(zeta1),cosd(zeta1)];
    R23 = [1,0,0;0,cosd(zeta2),-sind(zeta2);0,sind(zeta2),cosd(zeta2)];
    P01 = [0;0;0];
    P12 = [0;0;190];
    P23 = [0;200;0];
    
    % Calc P2
    P33S = R23*[0;0;0]+P23;
    P32S = R12*P33S+P12;
    P2 = R01*P32S+P01;
    
    % Calc zeta3
    P1 = [0; 0; 190];
    LP2P3 = P3-P2;
    %L13 = sqrt(sum(LP1P3.*LP1P3));
    %L23 = 130; L12 = 200; 
    %L03 = sqrt(sum(P3.*P3));
    %L01 = 190;
    zeta3 = acosd((sum(LP2P3.*Vector))/(norm(LP2P3)*norm(Vector)));
    
    
    % make sure zeta3 is correct
    nP = combined(zeta0,zeta1,zeta2,zeta3,0);
    if nP(1)-P(1)>0.0001
        zeta3 = -zeta3;
    end
    
    % Say ola again to Rotation Matrixes~
    zeta4=0;
    R01 = [cosd(zeta0),-sind(zeta0),0;sind(zeta0),cosd(zeta0),0;0,0,1];
    R12 = [1,0,0;0,cosd(zeta1),-sind(zeta1);0,sind(zeta1),cosd(zeta1)];
    R23 = [1,0,0;0,cosd(zeta2),-sind(zeta2);0,sind(zeta2),cosd(zeta2)];
    R34 = [1,0,0;0,cosd(zeta3),-sind(zeta3);0,sind(zeta3),cosd(zeta3)];
    R45 = [cosd(zeta4),0,sind(zeta4);0,1,0;-sind(zeta4),0,cosd(zeta4)];
    nA = R01*R12*R23*R34*R45;
    V1 = [nA(1,1);nA(2,1);nA(3,1)];
    V2 = [A(1,1);A(2,1);A(3,1)];
    zeta4 = acosd((sum(V1.*V2))/(norm(V1)*norm(V2)));
    R45 = [cosd(zeta4),0,sind(zeta4);0,1,0;-sind(zeta4),0,cosd(zeta4)]; 
    nA = R01*R12*R23*R34*R45;
    if nA(2,1)-A(2,1)> 0.00001
        zeta4 = 360 - zeta4;
    end
    fprintf('zeta0 = %.2f бу\n', zeta0 );
    fprintf('zeta1 = %.2f бу\n', zeta1 );
    fprintf('zeta2 = %.2f бу\n', zeta2 );
    fprintf('zeta3 = %.2f бу\n', zeta3 );
    fprintf('zeta4 = %.2f бу\n', zeta4 );

    
    
    %{
    % make sure the angles are reasonable
    if L12+L23 < L13
        fprintf('Fatal Error! Out of working space\n Please check your Orientation Matrix.. >.<..\n');
        return;

    % check if A2 is on the line of A1A3
    elseif L23+L12-L13<0.00001
        fprintf('find P2 on the L13\n');
        zeta2 = 0;
        Ang2 = acosd((L13^2 + L01^2 - L03^2)/(2*L13*L01));
        zeta1 = Ang2 - 90;
        zeta3 = acosd((sum(LP1P3.*Vector))/(norm(LP1P3)*norm(Vector)));
    else
        fprintf('find P2 NOT on the L13\nL13=%d',L13);
        Ang1 = acosd((L12^2 + L13^2 - L23^2)/(2*L12*L13));
        Ang2 = acosd((L13^2 + L01^2 - L03^2)/(2*L13*L01));
        zeta1 = Ang1 + Ang2 -90;
    
        Ang3 = acosd((L12^2 + L23^2 - L13^2)/(2*L12*L23));
        zeta2 = Ang3 - 180;
    
        zeta3 = 180-Ang1-Ang3;
    end
    
    %}
end

