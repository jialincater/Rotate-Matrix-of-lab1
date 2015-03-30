function [] = draw( P3,P4,P5,rotationMatrix )
    % P1 P2 initialized here
    P1 = [0;0;0];
    P2 = [0;0;190];
    
    % extract value of points
    x1 = P1(1); y1 = P1(2); z1 = P1(3); 
    x2 = P2(1); y2 = P2(2); z2 = P2(3);
    x3 = P3(1); y3 = P3(2); z3 = P3(3);
    x4 = P4(1); y4 = P4(2); z4 = P4(3);
    x5 = P5(1); y5 = P5(2); z5 = P5(3);
    
    % draw the lines with [plot3]
    plot3([x1,x2],[y1,y2],[z1,z2],[x1,x2],[y1,y2],[z1,z2],'g.','markersize',50);
    grid on;
    axis equal;
    view(116,20);
    hold on;
    plot3([x2,x3],[y2,y3],[z2,z3],[x2,x3],[y2,y3],[z2,z3],'g.','markersize',50);
    plot3([x3,x4],[y3,y4],[z3,z4],[x3,x4],[y3,y4],[z3,z4],'g.','markersize',50);
    plot3([x4,x5],[y4,y5],[z4,z5],[x4,x5],[y4,y5],[z4,z5],'g.','markersize',50);
    
    % Re-define the elements of the given matrix
    r11=rotationMatrix(1,1);r12=rotationMatrix(1,2);r13=rotationMatrix(1,3);
    r21=rotationMatrix(2,1);r22=rotationMatrix(2,2);r23=rotationMatrix(2,3);
    r31=rotationMatrix(3,1);r32=rotationMatrix(3,2);r33=rotationMatrix(3,3);

    % Draw the orientation of the end-effector
    quiver3(x5,y5,z5,r11,r21,r31,50,'r');
    quiver3(x5,y5,z5,r12,r22,r32,50,'m');
    quiver3(x5,y5,z5,r13,r23,r33,50,'b');
    hold off;
    xlabel('x-axis'); ylabel('y-axis'); zlabel('z-axis');
    title({'Determination of Euler Angles ZYZ by a given Rotation Matrix' ; 'Color of the Vector~Axis of the Orientation' ; 
        'Red~X-axis   Pink~Y-axis   Blue~Z-axis'});
end

