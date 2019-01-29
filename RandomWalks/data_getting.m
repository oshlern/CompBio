function [t_dist, f_dist, m_dist, s2m_dist, f_tax_dist, m_tax_dist, s2m_tax_dist, returns] = data_getting(points)

m_dist = 0;
s2m_dist = 0;
m_tax_dist = 0;
s2m_tax_dist = 0;
returns = 0;

t_dist = length(points);

visited_twice = [];

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
    
    if ismember(points(i,:),points(1:i-1,:))
        if ~ismember(points(i,:),visited_twice)
            visited_twice = [visited_twice; points(i, :)];
        end
    end
end

returns = size(visited_twice);
f_dist = L2(points(t_dist,1), points(t_dist,2));
f_tax_dist = L1(points(t_dist,1), points(t_dist,2));
