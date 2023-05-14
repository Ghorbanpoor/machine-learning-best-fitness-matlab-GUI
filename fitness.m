function  [Z]=fitness(x,gmdh,gmdh2,Min_F,Max_F)

% global gmdh gmdh2 Min_F Max_F

Outputs = ApplyGMDH(gmdh, x');

if Outputs<Min_F || Outputs>Max_F
    Z=0;
else
    Karaei = ApplyGMDH(gmdh2, [x Outputs]');
    if Karaei>1 
        Karaei=0;
    end

    Z=-Karaei;
end



end
