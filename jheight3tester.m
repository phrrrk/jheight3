%% jheight3 tester

for i = 16:16
  for k = 1:1
    trialName = ['Rohdaten/sub_no_', num2str(i), '_trial_', num2str(k), '.csv'];
    dataList{i-15,1} = trialName;
    try
      jumpHeight = jheight3(trialName, [50 500], 0, 0, 0, 0, 0, 1);
      dataList{i-15,k+1} = jumpHeight;
    end
  end
end