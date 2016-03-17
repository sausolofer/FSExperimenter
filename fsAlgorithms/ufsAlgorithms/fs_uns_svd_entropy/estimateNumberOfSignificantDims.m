%   function[num,everNum] = estimateNumberOfSignificantDims(S,threshold)
%   performs two methods for calculating 'elbow' in the singular values
%   input:
%           S = diagonal result of SVD
%           threshold = 0-1
%   output:
%            num    = the highest between the below two magnitudes    
%           accumNum = 1st method: summarize the accumulated variance
%           everNum = 2nd method: set a threshold for each singular value
%           (variance >= total variance *(0.7/n)
%           method optional parameter: 1st or 2nd calculating method if
%           that parameter is missing or if it equals to 1 the 1st method
%           is used.
%           entropy - as in Orly Alter's paper

function[num,entropy] = estimateNumberOfSignificantDims(S,threshold,method)
sos =trace(S^2);%sum of squares
relVar = diag((S^2)/sos);%relative variance 
len = length(relVar);

% entropy part
if length(find(relVar==0)) %the rank is lower than len
    minVar =min(relVar(find(relVar))); % find the non zero lowest Variance
    relVar(find(relVar==0)) = minVar;%the lowest variance is no zero anymore
end
logsVec = log2(relVar);
entropy = -(1/log2(len))*sum(logsVec.*relVar);
% end of entropy part
accumulateVar = 0; % accumulate variance
dims = 0;
for accumNum = 1: len
    accumulateVar = accumulateVar + relVar(accumNum);
    accumVec(accumNum) = accumulateVar;
    if (dims == 0) && (accumulateVar >= threshold)
        dims = accumNum;
    end
end

% xAxis =(1:1:len);
% %bar(xAxis,relVar,[0 xAxis],[0 accumVec]);% show the relative variance of the singular values
% hold on
% b=bar(xAxis,relVar,.5);
% h=plot([0 xAxis],[0 accumVec],'g','LineWidth',2);

% 
% title('Singular values after SVD procedure');
% xlabel('Component #');
% ylabel('Relative Variance');
% legend(b,'Relative Variance');
% legend([b ,h],'Relative Variance','Accumulated Value');
% xlim([0,len]);
% hold off
num = dims;
% if (nargin ==3) && method ==2
%     everThresh =(0.7/len)*sos;  % 2nd method: Everitt (2001) method
%     for everNum = 1:len
%         if everThresh> (S(everNum,everNum))^2
%             break;
%         end
%     end
%      num = everNum;
% end
% %   in use only if we need to decide between the two method (the input
% %   parameter isn't available)
% % if everNum>= dims
% %     num = everNum;
% % else
% %     num = dims;
% % end