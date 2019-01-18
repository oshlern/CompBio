function [t_dist, f_dist, m_dist, s2m_dist, f_tax_dist, m_tax_dist, s2m_tax_dist, repeats] = data_getting(points)

m_dist = 0;
s2m_dist = 0;
m_tax_dist = 0;
s2m_tax_dist = 0;
repeats = 0;

t_dist = length(points);


for i = 1:t_dist
    dist = L2(points(i,1), points(i,2));
    if dist > m_dist
        m_dist = dist;
        s2m_dist = i;
    end
    
    tax_dist = L1(points(i,1), points(i,2));
    if tax_dist > m_tax_dist
        m_tax_dist = tax_dist;
        s2m_tax_dist = i;
    end
    
    Working_point_x = points(i,1);
    Working_point_y = points(i,2);
    for j = (i+1):t_dist,
        if AND(points(j,1) == Working_point_x, points(j,2) == Working_point_y)
            repeats = repeats+1;
        end
    end
end

f_dist = L2(points(t_dist,1), points(t_dist,2));
f_tax_dist = L1(points(t_dist,1), points(t_dist,2));