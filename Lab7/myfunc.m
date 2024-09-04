function myfunc = myfunc
    myfunc.check = @check;
    myfunc.reverse = @reverse;
end

%% 对 2*2 区域的 最低比特位 进行 奇偶校验 判断
function res = check(m,i,j)
    temp = zeros(1,4);
    temp(1)=bitget(m(2*i-1,2*j-1),1);
    temp(2)=bitget(m(2*i-1,2*j),1);
    temp(3)=bitget(m(2*i,2*j-1),1);
    temp(4)=bitget(m(2*i,2*j),1);
    res = rem(sum(temp),2);
end

%% 对 2*2 区域的 最低比特位 进行 随机翻转
function res = reverse(m,i,j)
    random = int8(rand()*3);% 随机选择一位
     k = 2*i - 1;
     n = 2*j - 1;
    switch random
        case 0
            rs = bitget(m(k,n),1);
            rs = rem(rs + 1, 2); % (0 +1)%2= 1 ;  (1 +1)%2= 0
            m(k,n) = bitset(m(k,n),1,rs);
        case 1
            rs = bitget(m(k,n+1),1);
            rs = rem(rs + 1, 2); % (0 +1)%2= 1 ;  (1 +1)%2= 0
            m(k,n+1) = bitset(m(k,n+1),1,rs);
        case 2
            rs = bitget(m(k+1,n),1);
            rs = rem(rs + 1, 2); % (0 +1)%2= 1 ;  (1 +1)%2= 0
            m(k+1,n) = bitset(m(k+1,n),1,rs);
        case 3
            rs = bitget(m(k+1,n+1),1);
            rs = rem(rs + 1, 2); % (0 +1)%2= 1 ;  (1 +1)%2= 0
            m(k+1,n+1) = bitset(m(k+1,n+1),1,rs);
    end
    res = m;
end