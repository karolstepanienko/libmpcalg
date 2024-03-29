function func = getTrajectory(object)
% Returns proper trajectory getter based on object name
    if strcmp(object, '1x1') || strcmp(object, '1x2') || strcmp(object, '1x1Unstable')
        func = @getY1Trajectory;
    elseif strcmp(object, '2x2') || strcmp(object, '2x3')
        func = @getY2Trajectory;
    elseif strcmp(object, '1x1RelativeTest')
        func = @getY1RelativeTestTrajectory;
    elseif strcmp(object, '1x1SingleInertial')
        func = @getY1CompareTrajectory;
    end
end
