function [ ov ] = spikesOverlap( s1, s2 )
%spikes da due unia nello stesso millisecondo

s1 = round(s1 * 1000);
s2 = round(s2 * 1000);

c = intersect(s1, s2);

ov = length(c);

end

