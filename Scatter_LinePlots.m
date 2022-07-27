%% PLOT SCATTER/LINES
%This is for PTX and SIF-Ri

figure
%how to switch to arial font?  this does't work(fontname,'arial');
hold on
x = categorical({'PTX', 'SIF'}); 
x = reordercats(x,string(x)); %keeps them in the order i put them

for i_exp = 1 : length(SIF_Ri.exps) %start loop for #exps
    y = [SIF_Ri.PTX(i_exp), SIF_Ri.SIF(i_exp)];
    %SIFdot = SIF_intrinsic_Ri(i_exp).Ri_SIF;
    plot(x,y,'ko-', 'MarkerFaceColor','w','MarkerSize',5);
    end

avg_PTX=mean(SIF_Ri.PTX); %"omitnan" keeps the NaN out of the calculations
avg_SIF=mean(SIF_Ri.SIF);
y = [avg_PTX, avg_SIF];
plot(x,y,'r+', 'MarkerSize',20);
hold off

ax = gca; %this gets axes
xax = ax.XAxis; % gets the X axis
%set(xax, 'XLimitMethod', 'Tight');
set(xax,'TickDirection','out');
yax = ax.YAxis; % gets the Y axis
set(yax,'TickDirection','out');
ylim([0,35]);
axis 'tight'

%ax.XAxis.limitmethod = ('tight', 'tight'); %categorical({'PTX','SIF'});

% To adjust size of figure (useful for coreldraw)
% Also note, save as pdf to import into corel draw
fig = gcf;  %gets the current figure handle
fig.Units='inches';
fig.Position(3:4)= [1.5,1.8];  %fig.position returns left/right top/bottom width and height so fig.Position(3:4) lets me set the width and height

%% to Load Data
%This is written for CsCl and Riluzole
%Data is formatted as avg per experiment data in excel already

thefile=('N:\My Drive\GoogleDriveDocuments(10-9-17)\Manuscripts\SIFamide_LPG_IntrinsicProperties\Matlab\SIF_intrinsic_blockers_matlabformat.xlsx');
load('N:\My Drive\GoogleDriveDocuments(10-9-17)\Manuscripts\SIFamide_LPG_IntrinsicProperties\Matlab\SIF_Blockers.mat');

params = ["BD_Pre";"BD_Blocker";"BD_Post";"CP_Pre";"CP_Blocker";"CP_Post";"IBI_Pre";"IBI_Blocker";"IBI_Post"];
cond = ["CsCl_PDhype"; "CsCl_PDon"; "Ril_PDhype"];
sheet = ["Matlab_CsCl_PDhype"; "Matlab_CsCl_PDon"; "Ril_PDhype"];

for i_cond = 1: length(cond)
        xlData = readtable(thefile, 'Sheet', (sheet{i_cond})) ; %get the right sheet in the excel file
        x = xlData.EXP ; %this takes a column of exp names so we have that in the struct too
        SIF_Blockers.(cond{i_cond}).EXP = x; 
        
  for i_param= 1 : length(params)
        xlData = readtable(thefile, 'Sheet', (sheet{i_cond})) ; %get the right sheet in the excel file
        
        
            if i_param == 1  %this loop should figure out the # of exps in the first data set so we know highest # (other sets such as post-control might have some missing values)
                x = xlData.(params{i_param}) ; %get the column of data for each parameter on this sheet
                SIF_Blockers.(cond{i_cond}).(params{i_param}) = x(~isnan(x)) ; %this gets rid of all NaN and drops data in correct field
                numexps=length(SIF_Blockers.(cond{i_cond}).(params{i_param}));
                numexps=numexps;  %1 more than the # of exps
            else           
                x = xlData.(params{i_param}) ; %get the column of data for each parameter on this sheet
                SIF_Blockers.(cond{i_cond}).(params{i_param}) = x(1:numexps) ; %this puts just the # of exps into correct field, takes the NaN that are within the # of exps (missing values) but doesn't take the rest of the NaN down the whole column
            end
  end
   
end
save('N:\My Drive\GoogleDriveDocuments(10-9-17)\Manuscripts\SIFamide_LPG_IntrinsicProperties\Matlab\SIF_Blockers_data.mat') %save struct with histo data

%% PLOT SCATTER/LINES
%This is written for CsCl and Riluzole
%note save figures as pdf for CorelDraw

load('N:\My Drive\GoogleDriveDocuments(10-9-17)\Manuscripts\SIFamide_LPG_IntrinsicProperties\MATLAB\SIF_Blockers_data.mat')

cond = ["CsCl_PDhype"; "CsCl_PDon"; "Ril_PDhype"];
params = ["BD_Pre";"BD_Blocker";"BD_Post";"CP_Pre";"CP_Blocker";"CP_Post";"IBI_Pre";"IBI_Blocker";"IBI_Post"];

for i_cond = 1: length(cond)
  %numexps=SIF_Blockers.(cond{i_cond}).(params{1});
  

    %for i_param=1 : length(params) % to run through all params the same
    %way
    
    i_param = 1; %reset count for each condition
    %NOTE: I'm using fixed numbers for the params as you'll see below
    %instead of just looping through them one after another because I
    %want 3 sets of params grouped together, I don't want to do same thing
    %to each of the 9 parameters
    
t=(cond{i_cond});
figure('Name', t);
% To adjust size of figure (useful for coreldraw)
% Also note, save as pdf to import into corel draw
fig = gcf;  %gets the current figure handle
fig.Units='inches';
fig.Position(3:4)= [1.6,2.8];  %fig.position returns left/right top/bottom width and height so fig.Position(3:4) lets me set the width and height
tiledlayout(3,1);
nexttile  
        for i_exp = 1 : length(SIF_Blockers.(cond{i_cond}).(params{i_param})) %start loop for #exps 
            
         
            x = categorical({'SIF-Pre', 'SIF-Blocker', 'SIF-Post'}); 
            x = reordercats(x,string(x)); %keeps them in the order i put them
            y = [SIF_Blockers.(cond{i_cond}).(params{i_param}), SIF_Blockers.(cond{i_cond}).(params{i_param+1}), SIF_Blockers.(cond{i_cond}).(params{i_param+2})]; %gets the first three from param list
            plot(x,y,'ko-');
            hold on
            title('burstduration')
                if i_cond == 1
                   ylim([0,40]);
                end
                if i_cond == 2
                    ylim([0,35]);
                end
                if i_cond == 3
                    ylim([0,20])
                end
 
            ylabel=('Burst Duration(s)');
            plot(x,y,'ko','MarkerFaceColor','w','MarkerSize',5);
            pl = 'burst duration';
        end
           
            avg_pre=mean(SIF_Blockers.(cond{i_cond}).(params{i_param}),'omitnan'); %"omitnan" keeps the NaN out of the calculations
            avg_blocker=mean(SIF_Blockers.(cond{i_cond}).(params{i_param+1}),'omitnan');
            avg_post=mean(SIF_Blockers.(cond{i_cond}).(params{i_param+2}),'omitnan');
            SIF_Blockers.(cond{i_cond}).avg = [avg_pre;avg_blocker;avg_post]; %puts the avgs into an avg field for this condition
            x = categorical({'SIF-Pre', 'SIF-Blocker', 'SIF-Post'}); 
            x = reordercats(x,string(x)); %keeps them in the order i put them
            y = [avg_pre, avg_blocker, avg_post];
            plot(x,y,'c+', 'MarkerSize',20, 'LineStyle', 'none');
            hold off
            nexttile 
        
       for i_exp = 1 : length(SIF_Blockers.(cond{i_cond}).(params{i_param})) %start loop for #exps 
           
            x = categorical({'SIF-Pre', 'SIF-Blocker', 'SIF-Post'}); 
            x = reordercats(x,string(x)); %keeps them in the order i put them
            y = [SIF_Blockers.(cond{i_cond}).(params{i_param+3}), SIF_Blockers.(cond{i_cond}).(params{i_param+4}), SIF_Blockers.(cond{i_cond}).(params{i_param+5})];
            plot(x,y,'ko-');
            hold on
            plot(x,y,'ko','MarkerFaceColor','w','MarkerSize',5);
            title('cycle period')
            
                if i_cond == 1
                   ylim([0,40]);
                end
                if i_cond == 2
                    ylim([0,35]);
                end
                if i_cond == 3
                    ylim([0,20])
                end
            ylabel=('Cycle Period(s)');
        end
           
            avg_pre=mean(SIF_Blockers.(cond{i_cond}).(params{i_param+3}), 'omitnan');
            avg_blocker=mean(SIF_Blockers.(cond{i_cond}).(params{i_param+4}), 'omitnan');
            avg_post=mean(SIF_Blockers.(cond{i_cond}).(params{i_param+5}), 'omitnan');
            SIF_Blockers.(cond{i_cond}).avg(1:3,2) = [avg_pre;avg_blocker;avg_post];
            x = categorical({'SIF-Pre', 'SIF-Blocker', 'SIF-Post'}); 
            x = reordercats(x,string(x)); %keeps them in the order i put them
            y = [avg_pre, avg_blocker, avg_post];
            plot(x,y,'c+', 'MarkerSize',20, 'LineStyle', 'none');
        
            hold off
            nexttile
        
         for i_exp = 1 : length(SIF_Blockers.(cond{i_cond}).(params{i_param})) %start loop for #exps 
            x = categorical({'SIF-Pre', 'SIF-Blocker', 'SIF-Post'}); 
            x = reordercats(x,string(x)); %keeps them in the order i put them
            y = [SIF_Blockers.(cond{i_cond}).(params{i_param+6}), SIF_Blockers.(cond{i_cond}).(params{i_param+7}), SIF_Blockers.(cond{i_cond}).(params{i_param+8})];
            plot(x,y,'ko-');
            plot(x,y,'ko','MarkerFaceColor','w','MarkerSize',5);
            title('interburst interval')
            hold on
                            if i_cond == 1
                   ylim([0,40]);
                end
                if i_cond == 2
                    ylim([0,35]);
                end
                if i_cond == 3
                    ylim([0,20])
                end
            ylabel=('Interburst Interval(s)');
        end
           
        avg_pre=mean(SIF_Blockers.(cond{i_cond}).(params{i_param+6}), 'omitnan');
        avg_blocker=mean(SIF_Blockers.(cond{i_cond}).(params{i_param+7}), 'omitnan');
        avg_post=mean(SIF_Blockers.(cond{i_cond}).(params{i_param+8}), 'omitnan');
        SIF_Blockers.(cond{i_cond}).avg(1:3,3) = [avg_pre;avg_blocker;avg_post]; 
            x = categorical({'SIF-Pre', 'SIF-Blocker', 'SIF-Post'}); 
            x = reordercats(x,string(x)); %keeps them in the order i put them
            y = [avg_pre, avg_blocker, avg_post];
            plot(x,y,'c+', 'MarkerSize',20, 'LineStyle', 'none');
        
        hold off
             
    
end

%% For SFA ISIs
%This is for PTX and SIF-SFA

figure
%how to switch to arial font?  this does't work(fontname,'arial');
hold on
x = categorical({'PTX', 'SIF'}); 
x = reordercats(x,string(x)); %keeps them in the order i put them

for i_exp = 1 : length(SIF_ISI_Slope.exps) %start loop for #exps
    y = [SIF_ISI_Slope.PTX(i_exp), SIF_ISI_Slope.SIF(i_exp)];
    %SIFdot = SIF_intrinsic_Ri(i_exp).Ri_SIF;
    plot(x,y,'ko-', 'MarkerFaceColor','w','MarkerSize',10);
    
end

avg_PTX=mean(SIF_ISI_Slope.PTX); %"omitnan" keeps the NaN out of the calculations
avg_SIF=mean(SIF_ISI_Slope.SIF);
y = [avg_PTX, avg_SIF];
plot(x,y,'r+', 'MarkerSize',20);
hold off


ax = gca; %this gets axes
xax = ax.XAxis; % gets the X axis
%set(xax, 'XLimitMethod', 'Tight');
set(xax,'TickDirection','out');
axis 'tight'
yax = ax.YAxis; % gets the Y axis
set(yax,'TickDirection','out');
ylim([0,0.03]);


%ax.XAxis.limitmethod = ('tight', 'tight'); %categorical({'PTX','SIF'});

% To adjust size of figure (useful for coreldraw)
% Also note, save as pdf to import into corel draw
fig = gcf;  %gets the current figure handle
fig.Units='inches';
fig.Position(3:4)= [1.85,2.3];  %fig.position returns left/right top/bottom width and height so fig.Position(3:4) lets me set the width and height

%% For PIR data
%This is for PTX and SIF-PIR

figure
%how to switch to arial font?  this does't work(fontname,'arial');
hold on
x = categorical({'PTX', 'SIF'}); 
x = reordercats(x,string(x)); %keeps them in the order i put them


for i_exp = 1 : length(SIF_PIR.Exp) %start loop for #exps
    y = [SIF_PIR.PTX.AUC(i_exp), SIF_PIR.SIF.AUC(i_exp)]
    %SIFdot = SIF_intrinsic_Ri(i_exp).Ri_SIF;
    plot(x,y,'ko-', 'MarkerFaceColor','w','MarkerSize',8);
    
end

avg_PTX=mean(SIF_PIR.PTX.AUC); %"omitnan" keeps the NaN out of the calculations
avg_SIF=mean(SIF_PIR.SIF.AUC);
y = [avg_PTX, avg_SIF];
plot(x,y,'r+', 'MarkerSize',20);
hold off


ax = gca; %this gets axes
xax = ax.XAxis; % gets the X axis
%set(xax, 'XLimitMethod', 'Tight');
set(xax,'TickDirection','out');
axis 'tight'
yax = ax.YAxis; % gets the Y axis
set(yax,'TickDirection','out');
ylim([0,40]);


%ax.XAxis.limitmethod = ('tight', 'tight'); %categorical({'PTX','SIF'});

% To adjust size of figure (useful for coreldraw)
% Also note, save as pdf to import into corel draw
fig = gcf;  %gets the current figure handle
fig.Units='inches';
fig.Position(3:4)= [1.35,2.4];  %fig.position returns left/right top/bottom width and height so fig.Position(3:4) lets me set the width and height


% AND FOR SAG


figure
%how to switch to arial font?  this does't work(fontname,'arial');
hold on
x = categorical({'PTX', 'SIF'}); 
x = reordercats(x,string(x)); %keeps them in the order i put them

for i_exp = 1 : length(SIF_PIR.Exp) %start loop for #exps
    y = [SIF_PIR.PTX.Sag(i_exp), SIF_PIR.SIF.Sag(i_exp)]
    %SIFdot = SIF_intrinsic_Ri(i_exp).Ri_SIF;
    plot(x,y,'ko-', 'MarkerFaceColor','w','MarkerSize',8);
    
end

avg_PTX=mean(SIF_PIR.PTX.Sag); %"omitnan" keeps the NaN out of the calculations
avg_SIF=mean(SIF_PIR.SIF.Sag);
y = [avg_PTX, avg_SIF];
plot(x,y,'r+', 'MarkerSize',20);
hold off

ax = gca; %this gets axes
xax = ax.XAxis; % gets the X axis
%set(xax, 'XLimitMethod', 'Tight');
set(xax,'TickDirection','out');
axis 'tight'
yax = ax.YAxis; % gets the Y axis
set(yax,'TickDirection','out');
ylim([0,10]);


%ax.XAxis.limitmethod = ('tight', 'tight'); %categorical({'PTX','SIF'});

% To adjust size of figure (useful for coreldraw)
% Also note, save as pdf to import into corel draw
fig = gcf;  %gets the current figure handle
fig.Units='inches';
fig.Position(3:4)= [1.35,2.4];  %fig.position returns left/right top/bottom width and height so fig.Position(3:4) lets me set the width and height