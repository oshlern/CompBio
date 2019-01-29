function main(n)
[x,y] = bmsim1(0,0,1,1,n,2);
points = [x y];
[t_dist, f_dist, m_dist, s2m_dist, f_tax_dist, m_tax_dist, s2m_tax_dist, returns] = data_getting(points)