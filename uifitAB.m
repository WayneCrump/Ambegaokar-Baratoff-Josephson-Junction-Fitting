function uifitAB(argin)
% SIMPLE_GUI2 Select a data set from the pop-up menu, then
% click one of the plot-type push buttons. Clicking the button
% plots the selected data in the axes

% figure('Name','Simulation Plot Window','NumberTitle','off','units','normalized','Position',[0.2 0.2 0.75 0.75]);
%  Create and then hide the UI as it is being constructed.
test = char(916);
SCmtype = 'TypeIc';
Symmtype = 'Swave';
Dmmtype = '2DSample';
Bandmtype = 'Single';
Animtype = 'Ani';
legfontsize = 11;
legeloc = [400 21 0.2 0.2];
currentfilepaththing = 'R:\';
if nargin==0

    figure(311);close(311);figure(311);
    fprintf('T\tB\ttheta\tIc\tn\tV0\tslope\n');
    col=[.4 .6 .5];
    currdir=cd;
    set(311,'tag','uiJcfit',...
        'Units','normalized',...
        'position',[.1 .1 .6 .7],...
        'color',col,...
        'windowstyle','normal',...
        'userdata',[currdir '\'],...
        'numbertitle','off',...
        'name','Ambegaokar-Baratoff Josphson junction fits');
    zoom(311,'on')
    plotax=axes('tag','plotax',...
        'position',[.08 .3 .65 .65],...    
        'box','on');
    x=(1:51)';
    y=ones(size(x));%icfun(x,[40 10 .1 0]);
    %[x,y]=readjc('E:\Nick\BSCCO2005\high-field magnet\1830D\1830D-B2-L-perp\1830D-B2-L_perp_33.2K_5000mT.dat');
    dataline=line(x,y,'linestyle','none','marker','.','color','g','tag','dataline');
    calcline=line(x,y,'color','b','tag','calcline');
    xi=(0:.1:max(x))';
    yi=interp1(x,y,xi);
    fitline=line(xi,yi,'color','r','tag','fitline');
    %ylim([0 2])
    %set(plotax,'tag','plotax');
    fontsize(8)
    xlabel('Temperature (K)')
    ylabel('Self field Critical Current (A)')
    
    
    lege = legend(uiABEqnLegend(SCmtype,Symmtype,Dmmtype,Bandmtype),'Location',legeloc);
    set(lege,'Interpreter','latex')
    
    set(lege,'FontSize',legfontsize)
    
    
    % button and text box for loading files
    uicontrol('tag','filebox',...
        'Units','normalized',...
        'style','edit',...
        'position',[.05 .17 .6 .05],...
        'horizontalalignment','left',...
        'fontname','arial',...
        'fontsize',7,...
        'callback','uifitAB(''load'')')
    uicontrol('tag','browsebutton',...
        'Units','normalized',...
        'style','pushbutton',...
        'position',[.05 .08 .1 .07],...
        'string','Browse',...
        'callback','uifitAB(''browse'')')

    % save button
    uicontrol('tag','savebutton',...
        'Units','normalized',...
        'style','pushbutton',...
        'position',[.15 .08 .1 .07],...
        'string','Save fit',...
        'callback','uifitAB(''save'')')
    
    % lambda save button
    uicontrol('tag','lambutton',...
        'Units','normalized',...
        'style','pushbutton',...
        'position',[.25 .08 .1 .07],...
        'string','Blue Jc line to lambda',...
        'callback','uifitAB(''lamsave'')')
    
    % lambda save button
    uicontrol('tag','lambuttonexp',...
        'Units','normalized',...
        'style','pushbutton',...
        'position',[.35 .08 .1 .07],...
        'string','Experiment data Jc to lambda',...
        'callback','uifitAB(''lamexpsave'')');
    %boxes for entering dimensions
    %a width
    uicontrol('tag','labwidth',...
        'Units','normalized',...
        'style','text',...
        'position',[.75 .78 .05 .03],...
        'background',col,...
        'string','2a (um)')
    uicontrol('tag','parwidth',...
        'Units','normalized',...
        'style','edit',...
        'position',[.8 .78 .05 .03],...
        'string','2')
    %b thickness
    uicontrol('tag','labthick',...
        'Units','normalized',...
        'style','text',...
        'position',[.85 .78 .07 .03],...
        'background',col,...
        'string','2b (um)')
    uicontrol('tag','parthick',...
        'Units','normalized',...
        'style','edit',...
        'position',[.92 .78 .05 .03],...
        'string','1')
    
    
    
    
    %gap ratios 1
    uicontrol('tag','labgap1',...
        'Units','normalized',...
        'style','text',...
        'position',[.78 .745 .05 .03],...
        'background',col,...
        'string','Gap Ratio 1')
    
    uicontrol('tag','parGR1',...
        'Units','normalized',...
        'style','edit',...
        'position',[.78 .725 .05 .03],...
        'string','3.53')
    
    uicontrol('tag','labfixgap1',...
        'Units','normalized',...
        'style','text',...
        'position',[.83 .745 .03 .03],...
        'background',col,...
        'string','fix')
    
    uicontrol('tag','checkcouplingb1',...
        'Units','normalized',...
        'style','checkbox',...
        'position',[.84 .73 .014 .02],...
        'value',0,...
        'callback','uifitAB(''holdGR1'')')
    

    
    %gap ratios 2
    uicontrol('tag','labgap1',...
        'Units','normalized',...
        'style','text',...
        'position',[.88 .745 .05 .03],...
        'background',col,...
        'string','Gap Ratio 2')
        
    uicontrol('tag','parGR2',...
        'Units','normalized',...
        'style','edit',...
        'position',[.88 .725 .05 .03],...
        'string','3.53')
    
    uicontrol('tag','labfixgap2',...
        'Units','normalized',...
        'style','text',...
        'position',[.93 .745 .03 .03],...
        'background',col,...
        'string','fix')
    
    uicontrol('tag','checkcouplingb2',...
        'Units','normalized',...
        'style','checkbox',...
        'position',[.94 .73 .014 .02],...
        'value',0,...
        'callback','uifitAB(''holdGR2'')')
    
%     % place for entering kappa
%     uicontrol('tag','labkappa',...
%         'Units','normalized',...
%         'style','text',...
%         'position',[.75 .73 .05 .03],...
%         'background',col,...
%         'string','kappa')
    uicontrol('tag','parkappa',...
        'Units','normalized',...
        'style','edit',...
        'position',[.8 .73 .05 .03],...
        'string','95',...
        'visible','Off')
    

    
    % same dC/C
    uicontrol('tag','labsamedCC',...
        'Units','normalized',...
        'style','text',...
        'position',[.89 .96 .1 .03],...
        'background',col,...
        'string','Same dC/C')
    
    uicontrol('tag','checksdCC',...
        'Units','normalized',...
        'style','checkbox',...
        'position',[.975 .965 .02 .03],...
        'value',0,...
        'callback','uifitAB(''ChecksamedCC'')')
    
    % buttons for choosing symmetry
    uicontrol('tag','normaldbut',...
        'Units','normalized',...
        'style','pushbutton',...
        'position',[.79 .95 .04 .03],...
        'string','D wave',...
        'callback','uifitAB(''normald2'')')
    
    uicontrol('tag','normalsbut',...
        'Units','normalized',...
        'style','pushbutton',...
        'position',[.75 .95 .04 .03],...
        'string','S wave',...
        'callback','uifitAB(''normals2'')')
    
        % buttons for band and alpha/Jc model
    uicontrol('tag','alphadbut',...
        'Units','normalized',...
        'style','pushbutton',...
        'position',[.75 .88 .07 .03],...
        'string','Same Rn',...
        'callback','uifitAB(''Alphamodel'')')    
    
    uicontrol('tag','alphasbut',...
        'Units','normalized',...
        'style','pushbutton',...
        'position',[.75 .91 .07 .03],...
        'string','Single band',...
        'callback','uifitAB(''Singlemodel'')')
    
    uicontrol('tag','alphaslbut',...
        'Units','normalized',...
        'style','pushbutton',...
        'position',[.75 .85 .07 .03],...
        'string','Jc independent',...
        'callback','uifitAB(''Jcindependent'')')
    
    uicontrol('tag','alphadlbut',...
        'Units','normalized',...
        'style','pushbutton',...
        'position',[.75 .82 .07 .03],...
        'string','Alpha link Rn',...
        'callback','uifitAB(''LinkaRn'')')

    % buttons for choosing type I of II
    uicontrol('tag','typeIk0',...
        'Units','normalized',...
        'style','pushbutton',...
        'position',[.92 .93 .04 .025],...
        'string','Use Jc',...
        'callback','uifitAB(''typeIk0'')')
    
    uicontrol('tag','typeI',...
        'Units','normalized',...
        'Visible','off',...
        'style','pushbutton',...
        'position',[.92 .93 .04 .025],...
        'string','Use Jc',...
        'callback','uifitAB(''typeI'')')
    
    uicontrol('tag','typeII',...
        'Units','normalized',...
        'style','pushbutton',...
        'position',[.96 .93 .04 .025],...
        'string','Use Ic',...
        'callback','uifitAB(''typeII'')')
    
    % buttons for choosing dimensions or not or wire
    uicontrol('tag','NoDim',...
        'Units','normalized',...
        'style','pushbutton',...
        'position',[.84 .91 .051 .025],...
        'string','2D Sample',...
        'callback','uifitAB(''NoDimensions'')')
    
    uicontrol('tag','Dim',...
        'Units','normalized',...
        'style','pushbutton',...
        'position',[.84 .885 .051 .025],...
        'string','3D Sample',...
        'callback','uifitAB(''Dimensions'')')
    
    uicontrol('tag','Wire',...
        'Units','normalized',...
        'style','pushbutton',...
        'position',[.84 .86 .065 .025],...
        'string','Wire - Bessel',...
        'callback','uifitAB(''wire'')')
    
    uicontrol('tag','Wiretanh',...
        'Units','normalized',...
        'style','pushbutton',...
        'position',[.84 .835 .06 .025],...
        'string','Wire - Tanh',...
        'callback','uifitAB(''wiretanh'')')
    
    %text boxes saying the model type
    uicontrol('style','text',...
        'Units','normalized',...
        'position',[.91 .9 .09 .03],...
        'background',col,...
        'string','Model type')
    
    uicontrol('tag','SCtype',...
        'Units','normalized',...
        'style','edit',...
        'position',[.93 .88 .05 .03],...
        'string',SCmtype) 
    
    uicontrol('tag','symtype',...
        'Units','normalized',...
        'style','edit',...
        'position',[.96 .85 .04 .03],...
        'string',Symmtype)
    
    uicontrol('tag','Anitype',...
        'Units','normalized',...
        'style','edit',...
        'position',[.96 .82 .05 .03],...
        'string',Animtype,...
        'Visible','off')
    
    uicontrol('tag','Bandtype',...
        'Units','normalized',...
        'style','edit',...
        'position',[.91 .85 .05 .03],...
        'string',Bandmtype) 
    
    uicontrol('tag','Dmtype',...
        'Units','normalized',...
        'style','edit',...
        'position',[.91 .82 .05 .03],...
        'string',Dmmtype) 
    

    
titleh = 0.68; 
titlew = 0.76+0.06;
    % title text box above boxes specifying what things are
    uicontrol('tag','labValue',...
        'Units','normalized',...
        'style','text',...
        'position',[titlew titleh .05 .04],...
        'background',col,...
        'string','Value')
    uicontrol('tag','labError',...
        'Units','normalized',...
        'style','text',...
        'position',[titlew+.05 titleh .05 .04],...
        'background',col,...
        'string','Error')    
    uicontrol('tag','labDependency',...
        'Units','normalized',...
        'style','text',...
        'position',[titlew+.095 titleh .06 .04],...
        'background',col,...
        'string','Dependency')        
    uicontrol('tag','labfitchecks',...
        'Units','normalized',...
        'style','text',...
        'position',[titlew+.16 titleh .02 .04],...
        'background',col,...
        'string','Fit')
    
tcboxh = 0.67;    
tcboxw = 0.82;    
    % text boxes with Tc d0 c and lambda0 parameters
    %Tc
    uicontrol('tag','labTc',...
        'Units','normalized',...
        'style','text',...
        'position',[tcboxw-.05 tcboxh .05 .03],...
        'background',col,...
        'fontname','arial',...
        'string',['T_c (K)' test])
    uicontrol('tag','parTc',...
        'Units','normalized',...
        'style','edit',...
        'position',[tcboxw tcboxh .05 .03],...
        'string','40')
    uicontrol('tag','parTcErr',...
        'Units','normalized',...
        'style','edit',...
        'position',[tcboxw+.05 tcboxh .05 .03],...
        'string','0')
    uicontrol('tag','parTcDep',...
        'Units','normalized',...
        'style','edit',...
        'position',[tcboxw+.1 tcboxh .05 .03],...
        'string','0')    
    uicontrol('tag','checkTc',...
        'Units','normalized',...
        'style','checkbox',...
        'position',[tcboxw+.16 tcboxh .025 .03],...
        'value',1)

d0boxh = tcboxh-.03;
d0boxw = tcboxw;
    %d0
    uicontrol('tag','labd0',...
        'Units','normalized',...
        'style','text',...
        'position',[d0boxw-.06 d0boxh .06 .03],...
        'background',col,...
        'string','\Delta_0 (eV)')
    uicontrol('tag','pard0',...
        'Units','normalized',...
        'style','edit',...
        'position',[tcboxw d0boxh .05 .03],...
        'string','0.01')
    uicontrol('tag','pard0Err',...
        'Units','normalized',...
        'style','edit',...
        'position',[d0boxw+.05 d0boxh .05 .03],...
        'string','0')
    uicontrol('tag','pard0Dep',...
        'Units','normalized',...
        'style','edit',...
        'position',[d0boxw+.1 d0boxh .05 .03],...
        'string','0')        
    uicontrol('tag','checkd0',...
        'Units','normalized',...
        'style','checkbox',...
        'position',[d0boxw+.16 d0boxh .025 .03],...
        'value',1)
    
cboxh = d0boxh-.03;
cboxw = tcboxw;
    %c
    uicontrol('tag','labc',...
        'Units','normalized',...
        'style','text',...
        'position',[cboxw-.06 cboxh .06 .03],...
        'background',col,...
        'string','\DeltaC/C')
    uicontrol('tag','parc',...
        'Units','normalized',...
        'style','edit',...
        'position',[cboxw cboxh .05 .03],...
        'string','1')
    uicontrol('tag','parcErr',...
        'Units','normalized',...
        'style','edit',...
        'position',[cboxw+.05 cboxh .05 .03],...
        'string','0')
    uicontrol('tag','parcDep',...
        'Units','normalized',...
        'style','edit',...
        'position',[cboxw+.1 cboxh .05 .03],...
        'string','0')        
    uicontrol('tag','checkc',...
        'Units','normalized',...
        'style','checkbox',...
        'position',[cboxw+.16 cboxh .025 .03],...
        'value',1)

lambdaboxh = cboxh-.03;
lambdaboxw = tcboxw;
    %Lambda0
    uicontrol('tag','lablambda',...
        'Units','normalized',...
        'style','text',...
        'position',[lambdaboxw-.07 lambdaboxh .07 .03],...
        'background',col,...
        'string','R_norm1 (ohm)')
    uicontrol('tag','parlambda',...
        'Units','normalized',...
        'style','edit',...
        'position',[lambdaboxw lambdaboxh .05 .03],...
        'string','200')
    uicontrol('tag','parlambdaErr',...
        'Units','normalized',...
        'style','edit',...
        'position',[lambdaboxw+.05 lambdaboxh .05 .03],...
        'string','0')
    uicontrol('tag','parlambdaDep',...
        'Units','normalized',...
        'style','edit',...
        'position',[lambdaboxw+.1 lambdaboxh .05 .03],...
        'string','0')        
    uicontrol('tag','checklambda',...
        'Units','normalized',...
        'style','checkbox',...
        'position',[lambdaboxw+.16 lambdaboxh .025 .03],...
        'value',1)



    
%
alphaparm = uibuttongroup('tag','alphaparm',...
                'Units','normalized',...
                'Visible','off',...
                'Position',[0.75 0.34 0.25 0.24]);
sep = 0.14;
boxhi = .14;
titleh = 0.88; 
titlew = 0.2+0.06;
    % title text box above boxes specifying what things are
    uicontrol(alphaparm,'tag','labValue',...
        'Units','normalized',...
        'style','text',...
        'position',[titlew titleh .12 .1],...
        'string','Value')
    uicontrol(alphaparm,'tag','labError',...
        'Units','normalized',...
        'style','text',...
        'position',[titlew+.2 titleh .1 .1],...
        'string','Error')    
    uicontrol(alphaparm,'tag','labDependency',...
        'Units','normalized',...
        'style','text',...
        'position',[titlew+.35 titleh .22 .1],...
        'string','Dependency')        
    uicontrol(alphaparm,'tag','labfitchecks',...
        'Units','normalized',...
        'style','text',...
        'position',[titlew+.6 titleh .1 .1],...
        'string','Fit')
    
tcboxh = .75;    
tcboxw = .27;    
    % text boxes with Tc d0 c and lambda0 parameters
    %Tc
    uicontrol(alphaparm,'tag','labTc2',...
        'Units','normalized',...
        'style','text',...
        'position',[tcboxw-.2 tcboxh .2 boxhi],...
        'fontname','arial',...
        'string','T_c2 (K)')
    uicontrol(alphaparm,'tag','parTc2',...
        'Units','normalized',...
        'style','edit',...
        'position',[tcboxw tcboxh .21 boxhi],...
        'string','0.1')
    uicontrol(alphaparm,'tag','parTc2Err',...
        'Units','normalized',...
        'style','edit',...
        'position',[tcboxw+.21 tcboxh .21 boxhi],...
        'string','0')
    uicontrol(alphaparm,'tag','parTc2Dep',...
        'Units','normalized',...
        'style','edit',...
        'position',[tcboxw+.42 tcboxh .21 boxhi],...
        'string','0')    
    uicontrol(alphaparm,'tag','checkTc2',...
        'Units','normalized',...
        'style','checkbox',...
        'position',[tcboxw+.65 tcboxh .1 boxhi],...
        'value',1)

d0boxh = tcboxh-1*sep;
d0boxw = tcboxw;
    %d0
    uicontrol(alphaparm,'tag','labd02',...
        'Units','normalized',...
        'style','text',...
        'position',[d0boxw-.25 d0boxh .25 boxhi],...
        'fontname','arial',...
        'string','Delta_02 (eV)')
    uicontrol(alphaparm,'tag','pard02',...
        'Units','normalized',...
        'style','edit',...
        'position',[d0boxw d0boxh .21 boxhi],...
        'string','0.01')
    uicontrol(alphaparm,'tag','pard02Err',...
        'Units','normalized',...
        'style','edit',...
        'position',[d0boxw+.21 d0boxh .21 boxhi],...
        'string','0')
    uicontrol(alphaparm,'tag','pard02Dep',...
        'Units','normalized',...
        'style','edit',...
        'position',[d0boxw+.42 d0boxh .21 boxhi],...
        'string','0')    
    uicontrol(alphaparm,'tag','checkd02',...
        'Units','normalized',...
        'style','checkbox',...
        'position',[d0boxw+.65 d0boxh .1 boxhi],...
        'value',1)
    
cboxh = d0boxh-sep;
cboxw = tcboxw;
    %c
    uicontrol(alphaparm,'tag','labc2',...
        'Units','normalized',...
        'style','text',...
        'position',[cboxw-.2 cboxh .2 boxhi],...
        'fontname','arial',...
        'string','dC2/C2')
    uicontrol(alphaparm,'tag','parc2',...
        'Units','normalized',...
        'style','edit',...
        'position',[cboxw cboxh .21 boxhi],...
        'string','1')
    uicontrol(alphaparm,'tag','parc2Err',...
        'Units','normalized',...
        'style','edit',...
        'position',[cboxw+.21 cboxh .21 boxhi],...
        'string','0')
    uicontrol(alphaparm,'tag','parc2Dep',...
        'Units','normalized',...
        'style','edit',...
        'position',[cboxw+.42 cboxh .21 boxhi],...
        'string','0')    
    uicontrol(alphaparm,'tag','checkc2',...
        'Units','normalized',...
        'style','checkbox',...
        'position',[cboxw+.65 cboxh .1 boxhi],...
        'value',1)

    
lambdaboxh = cboxh-sep;
lambdaboxw = tcboxw;
    %Lambda0
    uicontrol(alphaparm,'tag','lablambda2',...
        'Units','normalized',...
        'style','text',...
        'position',[lambdaboxw-.28 lambdaboxh .28 boxhi],...
        'fontname','arial',...
        'string','R_norm2 (ohm)')
    uicontrol(alphaparm,'tag','parlambda2',...
        'Units','normalized',...
        'style','edit',...
        'position',[lambdaboxw lambdaboxh .21 boxhi],...
        'string','100')
    uicontrol(alphaparm,'tag','parlambda2Err',...
        'Units','normalized',...
        'style','edit',...
        'position',[lambdaboxw+.21 lambdaboxh .21 boxhi],...
        'string','0')
    uicontrol(alphaparm,'tag','parlambda2Dep',...
        'Units','normalized',...
        'style','edit',...
        'position',[lambdaboxw+.42 lambdaboxh .21 boxhi],...
        'string','0')    
    uicontrol(alphaparm,'tag','checklambda2',...
        'Units','normalized',...
        'style','checkbox',...
        'position',[lambdaboxw+.65 lambdaboxh .1 boxhi],...
        'value',1)
    
    
alphaboxh = lambdaboxh-sep;
alphaboxw = tcboxw;
    %Alpha
    uicontrol(alphaparm,'tag','labalpha',...
        'Units','normalized',...
        'style','text',...
        'position',[alphaboxw-.24 alphaboxh .24 boxhi],...
        'fontname','arial',...
        'string','alpha')
    uicontrol(alphaparm,'tag','paralpha',...
        'Units','normalized',...
        'style','edit',...
        'position',[alphaboxw alphaboxh .21 boxhi],...
        'string','0.5')
    uicontrol(alphaparm,'tag','paralphaErr',...
        'Units','normalized',...
        'style','edit',...
        'position',[alphaboxw+.21 alphaboxh .21 boxhi],...
        'string','0')
    uicontrol(alphaparm,'tag','paralphaDep',...
        'Units','normalized',...
        'style','edit',...
        'position',[alphaboxw+.42 alphaboxh .21 boxhi],...
        'string','0')    
    uicontrol(alphaparm,'tag','checkalpha',...
        'Units','normalized',...
        'style','checkbox',...
        'position',[alphaboxw+.65 alphaboxh .1 boxhi],...
        'value',1)
    
gapratioboxh = alphaboxh-sep;
gapratioboxw = tcboxw;
    %Alpha
    uicontrol(alphaparm,'tag','labgprAll',...
        'Units','normalized',...
        'style','text',...
        'position',[gapratioboxw-.24 gapratioboxh .24 boxhi],...
        'fontname','arial',...
        'string','Linked gap ratio')
    uicontrol(alphaparm,'tag','pargprAll',...
        'Units','normalized',...
        'style','edit',...
        'position',[gapratioboxw gapratioboxh .21 boxhi],...
        'string','0.5')
    uicontrol(alphaparm,'tag','pargprAllErr',...
        'Units','normalized',...
        'style','edit',...
        'position',[gapratioboxw+.21 gapratioboxh .21 boxhi],...
        'string','0')
    uicontrol(alphaparm,'tag','pargprAllDep',...
        'Units','normalized',...
        'style','edit',...
        'position',[gapratioboxw+.42 gapratioboxh .21 boxhi],...
        'string','0')    
    uicontrol(alphaparm,'tag','checkgprAll',...
        'Units','normalized',...
        'style','checkbox',...
        'position',[gapratioboxw+.65 gapratioboxh .1 boxhi],...
        'value',0,...
        'callback','uifitAB(''fitGRAll'')')    


    
    % box for how many points you want
    uicontrol('tag','labcalcpoints',...
        'Units','normalized',...
        'style','text',...
        'position',[.69 .14 .08 .1],...
        'background',col,...
        'string','Number of calculated points')
    uicontrol('tag','parcalcpoints',...
        'Units','normalized',...
        'style','edit',...
        'position',[.78 .2 .05 .03],...
        'string','50')    
    
    
    %function tolerance
    uicontrol('tag','labtolerance',...
        'Units','normalized',...
        'style','text',...
        'position',[.82 .25 .08 .03],...
        'background',col,...
        'string','Fitting Tolerance')
    uicontrol('tag','partolerance',...
        'Units','normalized',...
        'style','edit',...
        'position',[.90 .25 .05 .03],...
        'string','5e-24') 
    
    %Anisotropy fitting?
    
        % place for entering anisotropy
    uicontrol('tag','labAniso',...
        'Units','normalized',...
        'style','text',...
        'position',[.75 .31  .05 .03],...
        'background',col,...
        'string','Anisotropy')
    uicontrol('tag','parAniso',...
        'Units','normalized',...
        'style','edit',...
        'position',[.82 .31 .05 .03],...
        'string','1')    
    
    uicontrol('tag','parAnisoErr',...
        'Units','normalized',...
        'style','edit',...
        'position',[.82+.05 .31 .05 .03],...
        'string','0')
    uicontrol('tag','parAnisoDep',...
        'Units','normalized',...
        'style','edit',...
        'position',[.82+.1 .31 .05 .03],...
        'string','0')    
    uicontrol('tag','checkAniso',...
        'Units','normalized',...
        'style','checkbox',...
        'position',[.82+.16 .31 .025 .03],...
        'value',0)
    
    
    %Transperancy fitting?
    uicontrol('tag','labtrans',...
        'Units','normalized',...
        'style','text',...
        'position',[.75 .28 .06 .03],...
        'background',col,...
        'string','Transperancy')
    uicontrol('tag','partrans',...
        'Units','normalized',...
        'style','edit',...
        'position',[.82 .28 .05 .03],...
        'string','1') 
    uicontrol('tag','partransErr',...
        'Units','normalized',...
        'style','edit',...
        'position',[.82+.05 .28 .05 .03],...
        'string','0')
    uicontrol('tag','partransDep',...
        'Units','normalized',...
        'style','edit',...
        'position',[.82+.1 .28 .05 .03],...
        'string','0')    
    uicontrol('tag','checktrans',...
        'Units','normalized',...
        'style','checkbox',...
        'position',[.82+.16 .28 .025 .03],...
        'value',0)
    
    % box for how many iterations to do of fit
    uicontrol('tag','labits',...
        'Units','normalized',...
        'style','text',...
        'position',[.83 .2 .08 .03],...
        'background',col,...
        'string','Iterations')
    uicontrol('tag','parnumits',...
        'Units','normalized',...
        'style','edit',...
        'position',[.90 .2 .05 .03],...
        'string','1')  
    
    % R squared display value
    uicontrol('tag','labRs',...
        'Units','normalized',...
        'style','text',...
        'position',[.53 .95 .08 .03],...
        'background',col,...
        'string','R Squared')
    uicontrol('tag','parRs',...
        'Units','normalized',...
        'style','edit',...
        'position',[.60 .95 .05 .03],...
        'string','0')  
    
    % buttons for fitting and calculating
    uicontrol('tag','calcbutton',...
        'Units','normalized',...
        'style','pushbutton',...
        'position',[.75 .1 .1 .07],...
        'string','Calc',...
        'callback','uifitAB(''calc2'')')
    uicontrol('tag','fitbutton',...
        'Units','normalized',...
        'style','pushbutton',...
        'position',[.85 .1 0.1 .07],...
        'string','Fit',...
        'callback','uifitAB(''fit2'')')
    
    
   
    
else
    f1 = 311;
    plotax=findobj(f1,'tag','plotax');
    filebox=findobj(f1,'tag','filebox');
    parkappa=findobj(f1,'tag','parkappa');
    parAniso=findobj(f1,'tag','parAniso');
    
    tolerance=findobj(f1,'tag','partolerance');
    
    partrans=findobj(f1,'tag','partrans');
    partransErr=findobj(f1,'tag','partransErr');
    partransDep=findobj(f1,'tag','partransDep');
    
    pargprAll=findobj(f1,'tag','pargprAll');
    pargprAllErr=findobj(f1,'tag','pargprAllErr');
    pargprAllDep=findobj(f1,'tag','pargprAllDep');
    
    parAniso=findobj(f1,'tag','parAniso');
    parAnisoErr=findobj(f1,'tag','parAnisoErr');
    parAnisoDep=findobj(f1,'tag','parAnisoDep');
    
    parwidth=findobj(f1,'tag','parwidth');
    parthick=findobj(f1,'tag','parthick');
    
    parTc=findobj(f1,'tag','parTc');
    parTcErr=findobj(f1,'tag','parTcErr');
    parTcDep=findobj(f1,'tag','parTcDep');
    
    parTc2=findobj(f1,'tag','parTc2');
    parTc2Err=findobj(f1,'tag','parTc2Err');
    parTc2Dep=findobj(f1,'tag','parTc2Dep');
    
    pard0=findobj(f1,'tag','pard0');
    pard0Err=findobj(f1,'tag','pard0Err');
    pard0Dep=findobj(f1,'tag','pard0Dep');
    
    pard02=findobj(f1,'tag','pard02');
    pard02Err=findobj(f1,'tag','pard02Err');
    pard02Dep=findobj(f1,'tag','pard02Dep');
    
    parc=findobj(f1,'tag','parc');
    parcErr=findobj(f1,'tag','parcErr');
    parcDep=findobj(f1,'tag','parcDep');
    
    parc2=findobj(f1,'tag','parc2');
    parc2Err=findobj(f1,'tag','parc2Err');
    parc2Dep=findobj(f1,'tag','parc2Dep');
    
    parlambda=findobj(f1,'tag','parlambda');
    parlambdaErr=findobj(f1,'tag','parlambdaErr');
    parlambdaDep=findobj(f1,'tag','parlambdaDep');
    
    parlambda2=findobj(f1,'tag','parlambda2');
    parlambda2Err=findobj(f1,'tag','parlambda2Err');
    parlambda2Dep=findobj(f1,'tag','parlambda2Dep');

    
    paralpha=findobj(f1,'tag','paralpha');
    paralphaErr=findobj(f1,'tag','paralphaErr');
    paralphaDep=findobj(f1,'tag','paralphaDep');
    
    alphaparm = findobj(f1,'tag','alphaparm');
    
    parGR1 = findobj(f1,'tag','parGR1');
    parGR2 = findobj(f1,'tag','parGR2');
    
    parcalcpoints=findobj(f1,'tag','parcalcpoints');
    parnumits=findobj(f1,'tag','parnumits');
    symtype=findobj(f1,'tag','symtype');
    SCtype=findobj(f1,'tag','SCtype');
    Dmtype=findobj(f1,'tag','Dmtype');
    Bandtype=findobj(f1,'tag','Bandtype');
    Anitype=findobj(f1,'tag','Anitype');
    
    switch argin
        
    case 'browse'
        currentfilepaththing = get(filebox,'string');
        [fname,fpath] = uigetfile('*.csv','my title',...
                                    currentfilepaththing) ;
        if ischar(fpath)
            set(filebox,'string',[fpath fname])
        end
        uifitAB('load')
        
    case 'load'
        fname = get(filebox,'string');
        if exist(fname)==2
            [tvec jvec] = readsfjc(fname);
            dataline=findobj(f1,'tag','dataline');
            set(dataline,'xdata',tvec,'ydata',jvec)
            %dataline=line(tvec,jvec,'linestyle','none','marker','.','color','g','tag','dataline');
            set(parTc,'string',num2str(max(tvec)))
        end
        
    case 'save'
        
        model4 = get(Dmtype,'string');
        model2 = get(Bandtype,'string');
        model3 = get(symtype,'string');
        model1 = get(SCtype,'string');
        model = [model1 model2 model3 model4];
        calcline=findobj(f1,'tag','calcline');
        tdat = get(calcline,'xdata');
        jdat = get(calcline,'ydata');
        bvec = [tdat;jdat];
        currentfilepaththing = get(filebox,'string');
        [fname fpath] = uiputfile('.dat','my title',...
                                    currentfilepaththing);
        
        fileID = fopen([fpath fname],'w');
        fprintf(fileID,[fname '\n']);
        if strcmp(model2,'Single')
            fprintf(fileID,[model '\n']);
            fprintf(fileID,['2a = ' get(parwidth,'string') ', 2b = ' get(parthick,'string') '\n']);
            fprintf(fileID,['Tc = ' get(parTc,'string') ' error = ' get(parTcErr,'string') ' dependency = ' get(parTcDep,'string') '\n']);
            fprintf(fileID,['d0 = ' get(pard0,'string') ' error = ' get(pard0Err,'string') ' dependency = ' get(pard0Dep,'string') '\n']);
            fprintf(fileID,['c = ' get(parc,'string') ' error = ' get(parcErr,'string') ' dependency = ' get(parcDep,'string') '\n']);
            fprintf(fileID,['R_norm = ' get(parlambda,'string') ' error = ' get(parlambdaErr,'string') ' dependency = ' get(parlambdaDep,'string') '\n']);
            fprintf(fileID,['Transparency = ' get(partrans,'string') '\n']);
        elseif strcmp(model2,'LinkRn')
            fprintf(fileID,[model '\n']);
            fprintf(fileID,['2a = ' get(parwidth,'string') ', 2b = ' get(parthick,'string') '\n']);
            fprintf(fileID,['Tc = ' get(parTc,'string') ' error = ' get(parTcErr,'string') ' dependency = ' get(parTcDep,'string') '\n']);
            fprintf(fileID,['d0 = ' get(pard0,'string') ' error = ' get(pard0Err,'string') ' dependency = ' get(pard0Dep,'string') '\n']);
            fprintf(fileID,['c = ' get(parc,'string') ' error = ' get(parcErr,'string') ' dependency = ' get(parcDep,'string') '\n']);
            fprintf(fileID,['R_norm = ' get(parlambda,'string') ' error = ' get(parlambdaErr,'string') ' dependency = ' get(parlambdaDep,'string') '\n']);
            fprintf(fileID,['d02 = ' get(pard02,'string') ' error = ' get(pard02Err,'string') ' dependency = ' get(pard02Dep,'string') '\n']);
            fprintf(fileID,['c2 = ' get(parc2,'string') ' error = ' get(parc2Err,'string') ' dependency = ' get(parc2Dep,'string') '\n']);
            fprintf(fileID,['Transparency = ' get(partrans,'string') '\n']);
        elseif strcmp(model2,'Independent')
            fprintf(fileID,[model '\n']);
            fprintf(fileID,['2a = ' get(parwidth,'string') ', 2b = ' get(parthick,'string') '\n']);
            fprintf(fileID,['Tc = ' get(parTc,'string') ' error = ' get(parTcErr,'string') ' dependency = ' get(parTcDep,'string') '\n']);
            fprintf(fileID,['d0 = ' get(pard0,'string') ' error = ' get(pard0Err,'string') ' dependency = ' get(pard0Dep,'string') '\n']);
            fprintf(fileID,['c = ' get(parc,'string') ' error = ' get(parcErr,'string') ' dependency = ' get(parcDep,'string') '\n']);
            fprintf(fileID,['R_norm = ' get(parlambda,'string') ' error = ' get(parlambdaErr,'string') ' dependency = ' get(parlambdaDep,'string') '\n']);
            fprintf(fileID,['Tc2 = ' get(parTc2,'string') ' error = ' get(parTc2Err,'string') ' dependency = ' get(parTc2Dep,'string') '\n']);
            fprintf(fileID,['d02 = ' get(pard02,'string') ' error = ' get(pard02Err,'string') ' dependency = ' get(pard02Dep,'string') '\n']);
            fprintf(fileID,['c2 = ' get(parc2,'string') ' error = ' get(parc2Err,'string') ' dependency = ' get(parc2Dep,'string') '\n']);
            fprintf(fileID,['R_norm2 = ' get(parlambda2,'string') ' error = ' get(parlambda2Err,'string') ' dependency = ' get(parlambda2Dep,'string') '\n']);
            fprintf(fileID,['Transparency = ' get(partrans,'string') '\n']);
        elseif strcmp(model2,'LinkaRn')
            fprintf(fileID,[model '\n']);
            fprintf(fileID,['2a = ' get(parwidth,'string') ', 2b = ' get(parthick,'string') '\n']);
            fprintf(fileID,['Tc = ' get(parTc,'string') ' error = ' get(parTcErr,'string') ' dependency = ' get(parTcDep,'string') '\n']);
            fprintf(fileID,['d0 = ' get(pard0,'string') ' error = ' get(pard0Err,'string') ' dependency = ' get(pard0Dep,'string') '\n']);
            fprintf(fileID,['c = ' get(parc,'string') ' error = ' get(parcErr,'string') ' dependency = ' get(parcDep,'string') '\n']);
            fprintf(fileID,['R_norm = ' get(parlambda,'string') ' error = ' get(parlambdaErr,'string') ' dependency = ' get(parlambdaDep,'string') '\n']);
            fprintf(fileID,['Tc2 = ' get(parTc2,'string') ' error = ' get(parTc2Err,'string') ' dependency = ' get(parTc2Dep,'string') '\n']);
            fprintf(fileID,['d02 = ' get(pard02,'string') ' error = ' get(pard02Err,'string') ' dependency = ' get(pard02Dep,'string') '\n']);
            fprintf(fileID,['c2 = ' get(parc2,'string') ' error = ' get(parc2Err,'string') ' dependency = ' get(parc2Dep,'string') '\n']);
            fprintf(fileID,['alpha = ' get(paralpha,'string') ' error = ' get(paralphaErr,'string') ' dependency = ' get(paralphaDep,'string') '\n']);
            fprintf(fileID,['Transparency = ' get(partrans,'string') '\n']);
        else
            set(symtype,'string','please choose a model')
            fprintf(fileID,['Error no model choosen' '\n']);
        end   
        

        fprintf(fileID,'%6s %10s\n','T','Jc');
        fprintf(fileID,'%6f %10f\n',bvec);
        
        fclose(fileID);
    
    case 'lamexpsave'
        kappa = str2num(get(parkappa,'string'));
        Aniso = str2num(get(parAniso,'string'));
        awidth = str2num(get(parwidth,'string'));
        bthick = str2num(get(parthick,'string'));
        model4 = get(Dmtype,'string');
        model3 = get(symtype,'string');
        model1 = get(SCtype,'string');
        trans = str2num(get(partrans,'string'));
        fname = get(filebox,'string');
            % constants
        kb = 8.617*10^(-5);  %bolztmannzs
        fluxq = 2.067833758*10^(-15); %flux quantum
        mew0 = 4*pi*10^(-7); % Vacuum permeability
        kap = log(kappa)+0.5; %kappa reduced
        
        %Determine factor
        if ~isempty(strfind( model1 , 'TypeJc' ))
            factor = trans.*(fluxq*kappa/(sqrt(8)*pi*mew0));
        elseif ~isempty(strfind( model1 , 'TypeIc' ))
            factor = trans.*(fluxq*(kap)/(4*pi*mew0));
        end
        
        %determine geomtrey
        if ~isempty(strfind( model4 , '2DSample' ))
            rhs = @(Jc,lambda,awidth,bthick) Jc -  trans.*factor.*(1./lambda.^3);
        elseif ~isempty(strfind( model4 , '3DSample' ))
            if Aniso==1
                rhs = @(Jc,lambda,awidth,bthick) Jc - trans.*factor.*(1/(lambda.^2)).*( (1./((awidth*10^(-6)))).*tanh((awidth*10^(-6))./(lambda)) + (1./(bthick.*10^(-6))).*tanh((bthick.*10^(-6))./(lambda)));
            else
                rhs = @(Jc,lambda,awidth,bthick) Jc - trans.*factor.*(1/(lambda.^2)).*( (1./((awidth*10^(-6)).*Aniso.^(3/2))).*tanh((awidth*10^(-6))./(lambda)) + (log(Aniso)./(kap.*(awidth*10^(-6)).*Aniso.^(3/2))).*tanh((awidth*10^(-6))./(lambda)) + (Aniso./(bthick.*10^(-6))).*tanh((bthick.*10^(-6))./(Aniso.*lambda)));

            end
        elseif ~isempty(strfind( model4 , 'WireBessel' ))
            rhs = @(Jc,lambda,awidth,bthick) Jc - trans.*factor.*(1/(lambda.^2)).*(2./((awidth*10^(-6)))).*(besseli(1,(awidth*10^(-6))/(lambda))/besseli(0,(awidth*10^(-6))/(lambda)));
        elseif ~isempty(strfind( model4 , 'WireTanh' ))
            rhs = @(Jc,lambda,awidth,bthick) Jc - trans.*factor.*(1/(lambda.^2)).*(2./((awidth*10^(-6)))).*tanh(((awidth*10^(-6))./2)/(lambda));
        else
            error('Breaking out of function1');
        end
        
        
        a2 = awidth/2;
        b2 = bthick/2;
        
        mvec = csvread([fname]);
        tvec = mvec(:,1);
        jvec = mvec(:,2);
        
        lamvec = zeros(length(tvec),1);
        for ii = 1:length(tvec)
            F = @(x) rhs(jvec(ii),x,a2,b2);
            lamvec(ii) = fsolve(F,10^-7);
        end
        bvec = [tvec';jvec';lamvec'];
        currentfilepaththing = get(filebox,'string');
        [fname fpath] = uiputfile('.dat','my title',...
                                    currentfilepaththing);
        fileID = fopen([fpath fname],'w');
        fprintf(fileID,'%12s %12s %12s\n','T','Jc(T)','Lambda(T)');
        fprintf(fileID,'%12.6f %12.12f %12.12f\n',bvec);

        fclose(fileID);
        
        
        
    case 'lamsave'
        testTc = str2num(get(parTc,'string'));
        testTc2 = str2num(get(parTc2,'string'));
        testd0 = str2num(get(pard0,'string'));
        testd02 = str2num(get(pard02,'string'));
        testc = str2num(get(parc,'string'));
        testc2 = str2num(get(parc2,'string'));
        testlambda = str2num(get(parlambda,'string'));
        testlambda2 = str2num(get(parlambda2,'string'));
        testalpha = str2num(get(paralpha,'string'));
        Aniso = str2num(get(parAniso,'string'));
        kappa = str2num(get(parkappa,'string'));
        awidth = str2num(get(parwidth,'string'));
        bthick = str2num(get(parthick,'string'));
        calcpoints = str2num(get(parcalcpoints,'string'));
        model4 = get(Dmtype,'string');
        model2 = get(Bandtype,'string');
        model3 = get(symtype,'string');
        model1 = get(SCtype,'string');
        model = [model1 model2 model3 model4];       
        trans = str2num(get(partrans,'string'));
        dataline=findobj(f1,'tag','dataline');
        calcline=findobj(f1,'tag','calcline');
        tdat = get(calcline,'xdata')';
        jdat = get(calcline,'ydata')';
        
            % constants
        kb = 8.617*10^(-5);  %bolztmannzs
        fluxq = 2.067833758*10^(-15); %flux quantum
        mew0 = 4*pi*10^(-7); % Vacuum permeability
        kap = log(kappa)+0.5; %kappa reduced
        
        %Determine factor
        if ~isempty(strfind( model1 , 'TypeJc' ))
            factor = (fluxq*kappa/(sqrt(8)*pi*mew0));
        elseif ~isempty(strfind( model1 , 'TypeIc' ))
            factor = (fluxq*(kap)/(4*pi*mew0));
        end
        
        %determine geomtrey
        if ~isempty(strfind( model4 , '2DSample' ))
            rhs = @(Jc,lambda,awidth,bthick) Jc -  trans.*factor.*(1./lambda.^3);
        elseif ~isempty(strfind( model4 , '3DSample' ))
            if Aniso==1
                rhs = @(Jc,lambda,awidth,bthick) Jc - trans.*factor.*(1./(lambda.^2)).*( (1./((awidth*10^(-6)))).*tanh((awidth.*10^(-6))./(lambda)) + (1./(bthick.*10^(-6))).*tanh((bthick.*10^(-6))./(lambda)));
            else
                rhs = @(Jc,lambda,awidth,bthick) Jc - trans.*factor.*(1./(lambda.^2)).*( (1./((awidth*10^(-6)).*Aniso.^(3/2))).*tanh((awidth*10^(-6))./(lambda)) + (log(Aniso)./(kap.*(awidth*10^(-6)).*Aniso.^(3/2))).*tanh((awidth*10^(-6))./(lambda)) + (Aniso./(bthick.*10^(-6))).*tanh((bthick.*10^(-6))./(Aniso.*lambda)));

            end
        elseif ~isempty(strfind( model4 , 'WireBessel' ))
            rhs = @(Jc,lambda,awidth,bthick) Jc - trans.*factor.*(1./(lambda.^2)).*(2./((awidth.*10^(-6)))).*(besseli(1,(awidth.*10^(-6))./(lambda))./besseli(0,(awidth*10^(-6))./(lambda)));
        elseif ~isempty(strfind( model4 , 'WireTanh' ))
            rhs = @(Jc,lambda,awidth,bthick) Jc - trans.*factor.*(1./(lambda.^2)).*(2./((awidth.*10^(-6)))).*tanh(((awidth.*10^(-6))./2)./(lambda));
        else
            error('Breaking out of function1');
        end
        
        a2 = awidth/2;
        b2 = bthick/2;
        
        
        lamvec = zeros(length(tdat),1);
        for ii = 1:length(tdat)
            F = @(x) rhs(jdat(ii),x,a2,b2);
            lamvec(ii) = fsolve(F,10^-7);
        end
        
        bvec = [tdat';jdat';lamvec'];
        currentfilepaththing = get(filebox,'string');
        [fname fpath] = uiputfile('.dat','my title',...
                                    currentfilepaththing);
        
        fileID = fopen([fpath fname],'w');
        fprintf(fileID,[fname '\n']);
        
        if strcmp(model2,'Single')
            fprintf(fileID,[model '\n']);
            fprintf(fileID,['2a = ' get(parwidth,'string') ', 2b = ' get(parthick,'string') '\n']);
            fprintf(fileID,['Tc = ' get(parTc,'string') ' error = ' get(parTcErr,'string') ' dependency = ' get(parTcDep,'string') '\n']);
            fprintf(fileID,['d0 = ' get(pard0,'string') ' error = ' get(pard0Err,'string') ' dependency = ' get(pard0Dep,'string') '\n']);
            fprintf(fileID,['c = ' get(parc,'string') ' error = ' get(parcErr,'string') ' dependency = ' get(parcDep,'string') '\n']);
            fprintf(fileID,['R_norm = ' get(parlambda,'string') ' error = ' get(parlambdaErr,'string') ' dependency = ' get(parlambdaDep,'string') '\n']);
            fprintf(fileID,['Transparency = ' get(partrans,'string') '\n']);
        elseif strcmp(model2,'LinkRn')
            fprintf(fileID,[model '\n']);
            fprintf(fileID,['2a = ' get(parwidth,'string') ', 2b = ' get(parthick,'string') '\n']);
            fprintf(fileID,['Tc = ' get(parTc,'string') ' error = ' get(parTcErr,'string') ' dependency = ' get(parTcDep,'string') '\n']);
            fprintf(fileID,['d0 = ' get(pard0,'string') ' error = ' get(pard0Err,'string') ' dependency = ' get(pard0Dep,'string') '\n']);
            fprintf(fileID,['c = ' get(parc,'string') ' error = ' get(parcErr,'string') ' dependency = ' get(parcDep,'string') '\n']);
            fprintf(fileID,['R_norm = ' get(parlambda,'string') ' error = ' get(parlambdaErr,'string') ' dependency = ' get(parlambdaDep,'string') '\n']);
            fprintf(fileID,['d02 = ' get(pard02,'string') ' error = ' get(pard02Err,'string') ' dependency = ' get(pard02Dep,'string') '\n']);
            fprintf(fileID,['c2 = ' get(parc2,'string') ' error = ' get(parc2Err,'string') ' dependency = ' get(parc2Dep,'string') '\n']);
            fprintf(fileID,['Transparency = ' get(partrans,'string') '\n']);
        elseif strcmp(model2,'Independent')
            fprintf(fileID,[model '\n']);
            fprintf(fileID,['2a = ' get(parwidth,'string') ', 2b = ' get(parthick,'string') '\n']);
            fprintf(fileID,['Tc = ' get(parTc,'string') ' error = ' get(parTcErr,'string') ' dependency = ' get(parTcDep,'string') '\n']);
            fprintf(fileID,['d0 = ' get(pard0,'string') ' error = ' get(pard0Err,'string') ' dependency = ' get(pard0Dep,'string') '\n']);
            fprintf(fileID,['c = ' get(parc,'string') ' error = ' get(parcErr,'string') ' dependency = ' get(parcDep,'string') '\n']);
            fprintf(fileID,['R_norm = ' get(parlambda,'string') ' error = ' get(parlambdaErr,'string') ' dependency = ' get(parlambdaDep,'string') '\n']);
            fprintf(fileID,['Tc2 = ' get(parTc2,'string') ' error = ' get(parTc2Err,'string') ' dependency = ' get(parTc2Dep,'string') '\n']);
            fprintf(fileID,['d02 = ' get(pard02,'string') ' error = ' get(pard02Err,'string') ' dependency = ' get(pard02Dep,'string') '\n']);
            fprintf(fileID,['c2 = ' get(parc2,'string') ' error = ' get(parc2Err,'string') ' dependency = ' get(parc2Dep,'string') '\n']);
            fprintf(fileID,['R_norm2 = ' get(parlambda2,'string') ' error = ' get(parlambda2Err,'string') ' dependency = ' get(parlambda2Dep,'string') '\n']);
            fprintf(fileID,['Transparency = ' get(partrans,'string') '\n']);
        elseif strcmp(model2,'LinkaRn')
            fprintf(fileID,[model '\n']);
            fprintf(fileID,['2a = ' get(parwidth,'string') ', 2b = ' get(parthick,'string') '\n']);
            fprintf(fileID,['Tc = ' get(parTc,'string') ' error = ' get(parTcErr,'string') ' dependency = ' get(parTcDep,'string') '\n']);
            fprintf(fileID,['d0 = ' get(pard0,'string') ' error = ' get(pard0Err,'string') ' dependency = ' get(pard0Dep,'string') '\n']);
            fprintf(fileID,['c = ' get(parc,'string') ' error = ' get(parcErr,'string') ' dependency = ' get(parcDep,'string') '\n']);
            fprintf(fileID,['R_norm = ' get(parlambda,'string') ' error = ' get(parlambdaErr,'string') ' dependency = ' get(parlambdaDep,'string') '\n']);
            fprintf(fileID,['Tc2 = ' get(parTc2,'string') ' error = ' get(parTc2Err,'string') ' dependency = ' get(parTc2Dep,'string') '\n']);
            fprintf(fileID,['d02 = ' get(pard02,'string') ' error = ' get(pard02Err,'string') ' dependency = ' get(pard02Dep,'string') '\n']);
            fprintf(fileID,['c2 = ' get(parc2,'string') ' error = ' get(parc2Err,'string') ' dependency = ' get(parc2Dep,'string') '\n']);
            fprintf(fileID,['alpha = ' get(paralpha,'string') ' error = ' get(paralphaErr,'string') ' dependency = ' get(paralphaDep,'string') '\n']);
            fprintf(fileID,['Transparency = ' get(partrans,'string') '\n']);
        else
            set(symtype,'string','please choose a model')
            fprintf(fileID,['Error no model choosen' '\n']);
        end  
        
        
        
        fprintf(fileID,'%6s %10s %10s\n','T','Jc','Lambda(T)');
        fprintf(fileID,'%6f %10.15f %10.15f\n',bvec);
        fclose(fileID);
        
    case 'NoDimensions'
        Dmmtype = '2DSample';
        set(Dmtype,'string',Dmmtype)
        set(parAniso,'Visible','off')
        set(parthick,'Visible','off')
        set(parwidth,'Visible','off')
        
        lege = legend(uiABEqnLegend(get(SCtype,'string'),get(symtype,'string'),get(Dmtype,'string'),get(Bandtype,'string')),legeloc);
        set(lege,'Interpreter','latex')
        set(lege,'FontSize',legfontsize)
        
    
    case 'Dimensions'
        Dmmtype = '3DSample';
        set(Dmtype,'string',Dmmtype)
        set(parAniso,'Visible','off')
        set(parthick,'Visible','on')
        set(parwidth,'Visible','on')
        
        lege = legend(uiABEqnLegend(get(SCtype,'string'),get(symtype,'string'),get(Dmtype,'string'),get(Bandtype,'string')),legeloc);
        set(lege,'Interpreter','latex')
        set(lege,'FontSize',legfontsize)
    case 'wire'
        Dmmtype = 'WireBessel';
        set(Dmtype,'string',Dmmtype)
        set(parAniso,'Visible','off')
        set(parthick,'Visible','off')
        set(parwidth,'Visible','on')
        
        lege = legend(uiABEqnLegend(get(SCtype,'string'),get(symtype,'string'),get(Dmtype,'string'),get(Bandtype,'string')),legeloc);
        set(lege,'Interpreter','latex')
        set(lege,'FontSize',legfontsize)
    case 'wiretanh'
        Dmmtype = 'WireTanh';
        set(Dmtype,'string',Dmmtype)
        set(parAniso,'Visible','off')
        set(parthick,'Visible','off')
        set(parwidth,'Visible','on')
        
        lege = legend(uiABEqnLegend(get(SCtype,'string'),get(symtype,'string'),get(Dmtype,'string'),get(Bandtype,'string')),legeloc);
        set(lege,'Interpreter','latex')
        set(lege,'FontSize',legfontsize)
    case 'typeIk0'
        SCmtype = 'TypeJc';
        ylabel('Self field Critical Current density (A/m^2)')
        set(SCtype,'string',SCmtype)
        
        lege = legend(uiABEqnLegend(get(SCtype,'string'),get(symtype,'string'),get(Dmtype,'string'),get(Bandtype,'string')),legeloc);
        set(lege,'Interpreter','latex')
        set(lege,'FontSize',legfontsize)
        
    %case 'typeI'
    %    SCmtype = 'TypeI';
    %    set(SCtype,'string',SCmtype)
    %    set(parAniso,'Visible','off')

    case 'typeII'
        SCmtype = 'TypeIc';
        ylabel('Self field Critical Current (A)')
        set(SCtype,'string',SCmtype)
        
        lege = legend(uiABEqnLegend(get(SCtype,'string'),get(symtype,'string'),get(Dmtype,'string'),get(Bandtype,'string')),legeloc);
        set(lege,'Interpreter','latex')
        set(lege,'FontSize',legfontsize)
    case 'normald2'
        Symmtype = 'Dwave';
        set(parGR1,'string','4.28')
        set(parGR2,'string','4.28')
        set(symtype,'string',Symmtype)
        
        lege = legend(uiABEqnLegend(get(SCtype,'string'),get(symtype,'string'),get(Dmtype,'string'),get(Bandtype,'string')),legeloc);
        set(lege,'Interpreter','latex')
        set(lege,'FontSize',legfontsize)
        
    case 'normals2'
        Symmtype = 'Swave';
        set(parGR1,'string','3.53')
        set(parGR2,'string','3.53')
        set(symtype,'string',Symmtype)
        
        lege = legend(uiABEqnLegend(get(SCtype,'string'),get(symtype,'string'),get(Dmtype,'string'),get(Bandtype,'string')),legeloc);
        set(lege,'Interpreter','latex')
        set(lege,'FontSize',legfontsize)
        
    case 'NoAni'
        Animtype = '';
        set(Anitype,'string',Animtype)
        
    case 'Aniso'
        Animtype = 'Ani';
        set(Anitype,'string',Animtype)
        
    case 'Singlemodel'
        set(alphaparm,'Visible','off')
        Bandmtype = 'Single';
        set(Bandtype,'string',Bandmtype)
        set(findobj('tag','checkgprAll'),'value',0);
        lege = legend(uiABEqnLegend(get(SCtype,'string'),get(symtype,'string'),get(Dmtype,'string'),get(Bandtype,'string')),legeloc);
        set(lege,'Interpreter','latex')
        set(lege,'FontSize',legfontsize)
        checkGR1 = get(findobj('tag','checkcouplingb1'),'value');
        checkGR2 = get(findobj('tag','checkcouplingb2'),'value');
        if checkGR1==1
            set(findobj('tag','checkgprAll'),'value',0);
            set(pard0,'Visible','on')
            set(pard0Err,'Visible','off')
            set(pard0Dep,'Visible','off')
            set(findobj('tag','checkd0'),'Visible','off')
        else
            set(pard0,'Visible','on')
            set(pard0Err,'Visible','on')
            set(pard0Dep,'Visible','on')
            set(findobj('tag','checkd0'),'Visible','on')
        end
        if checkGR2==1
            set(findobj('tag','checkgprAll'),'value',0);
            set(pard02,'Visible','on')
            set(pard02Err,'Visible','off')
            set(pard02Dep,'Visible','off')
            set(findobj('tag','checkd02'),'Visible','off')
        else
            set(pard02,'Visible','on')
            set(pard02Err,'Visible','on')
            set(pard02Dep,'Visible','on')
            set(findobj('tag','checkd02'),'Visible','on')
        end
            

    case 'Alphamodel'
        set(alphaparm,'Visible','on')
        
        
        set(parTc2,'Visible','on')
        set(parTc2Err,'Visible','on')
        set(parTc2Dep,'Visible','on')
        set(findobj('tag','checkTc2'),'Visible','on')
        
        set(parlambda2,'Visible','off')
        set(parlambda2Err,'Visible','off')
        set(parlambda2Dep,'Visible','off')
        set(findobj('tag','checklambda2'),'Visible','off')
        
        set(paralpha,'Visible','off')
        set(paralphaErr,'Visible','off')
        set(paralphaDep,'Visible','off')
        set(findobj('tag','checkalpha'),'Visible','off')
        
        Bandmtype = 'LinkRn';
        set(Bandtype,'string',Bandmtype)
        lege = legend(uiABEqnLegend(get(SCtype,'string'),get(symtype,'string'),get(Dmtype,'string'),get(Bandtype,'string')),legeloc);
        set(lege,'Interpreter','latex')
        set(lege,'FontSize',legfontsize)
        
    case 'Jcindependent'
        set(alphaparm,'Visible','on')
        
        set(parTc2,'Visible','on')
        set(parTc2Err,'Visible','on')
        set(parTc2Dep,'Visible','on')
        set(findobj('tag','checkTc2'),'Visible','on')

        set(parlambda2,'Visible','on')
        set(parlambda2Err,'Visible','on')
        set(parlambda2Dep,'Visible','on')
        set(findobj('tag','checklambda2'),'Visible','on')
        
        set(paralpha,'Visible','off')
        set(paralphaErr,'Visible','off')
        set(paralphaDep,'Visible','off')
        set(findobj('tag','checkalpha'),'Visible','off')
        
        Bandmtype = 'Independent';
        set(Bandtype,'string',Bandmtype)
        lege = legend(uiABEqnLegend(get(SCtype,'string'),get(symtype,'string'),get(Dmtype,'string'),get(Bandtype,'string')),legeloc);
        set(lege,'Interpreter','latex')
        set(lege,'FontSize',legfontsize)
        
    case 'LinkaRn'
        set(alphaparm,'Visible','on')
        
        set(parTc2,'Visible','on')
        set(parTc2Err,'Visible','on')
        set(parTc2Dep,'Visible','on')
        set(findobj('tag','checkTc2'),'Visible','on')

        set(parlambda2,'Visible','off')
        set(parlambda2Err,'Visible','off')
        set(parlambda2Dep,'Visible','off')
        set(findobj('tag','checklambda2'),'Visible','off')
        
        set(paralpha,'Visible','on')
        set(paralphaErr,'Visible','on')
        set(paralphaDep,'Visible','on')
        set(findobj('tag','checkalpha'),'Visible','on')
        Bandmtype = 'LinkaRn';
        set(Bandtype,'string',Bandmtype)
        lege = legend(uiABEqnLegend(get(SCtype,'string'),get(symtype,'string'),get(Dmtype,'string'),get(Bandtype,'string')),legeloc);
        set(lege,'Interpreter','latex')
        set(lege,'FontSize',legfontsize)
        
    % check box changes
    case 'ChecksamedCC'
        checksdCC = get(findobj('tag','checksdCC'),'value');
        if checksdCC==1
            set(parc2,'Visible','off')
            set(parc2Err,'Visible','off')
            set(parc2Dep,'Visible','off')
            set(findobj('tag','checkc2'),'Visible','off')
        else
            set(parc2,'Visible','on')
            set(parc2Err,'Visible','on')
            set(parc2Dep,'Visible','on')
            set(findobj('tag','checkc2'),'Visible','on')
        end
        
    case 'holdGR1'
        checkGR1 = get(findobj('tag','checkcouplingb1'),'value');
        checkGR2 = get(findobj('tag','checkcouplingb2'),'value');
        if checkGR1==1
            set(findobj('tag','checkgprAll'),'value',0);
            set(pard0,'Visible','on')
            set(pard0Err,'Visible','off')
            set(pard0Dep,'Visible','off')
            set(findobj('tag','checkd0'),'Visible','off')
        else
            set(pard0,'Visible','on')
            set(pard0Err,'Visible','on')
            set(pard0Dep,'Visible','on')
            set(findobj('tag','checkd0'),'Visible','on')
        end
        if checkGR2==1
            set(findobj('tag','checkgprAll'),'value',0);
            set(pard02,'Visible','on')
            set(pard02Err,'Visible','off')
            set(pard02Dep,'Visible','off')
            set(findobj('tag','checkd02'),'Visible','off')
        else
            set(pard02,'Visible','on')
            set(pard02Err,'Visible','on')
            set(pard02Dep,'Visible','on')
            set(findobj('tag','checkd02'),'Visible','on')
        end

    case 'holdGR2'
        checkGR1 = get(findobj('tag','checkcouplingb1'),'value');
        checkGR2 = get(findobj('tag','checkcouplingb2'),'value');
        if checkGR1==1
            set(findobj('tag','checkgprAll'),'value',0);
            set(pard0,'Visible','on')
            set(pard0Err,'Visible','off')
            set(pard0Dep,'Visible','off')
            set(findobj('tag','checkd0'),'Visible','off')
        else
            set(pard0,'Visible','on')
            set(pard0Err,'Visible','on')
            set(pard0Dep,'Visible','on')
            set(findobj('tag','checkd0'),'Visible','on')
        end
        if checkGR2==1
            set(findobj('tag','checkgprAll'),'value',0);
            set(pard02,'Visible','on')
            set(pard02Err,'Visible','off')
            set(pard02Dep,'Visible','off')
            set(findobj('tag','checkd02'),'Visible','off')
        else
            set(pard02,'Visible','on')
            set(pard02Err,'Visible','on')
            set(pard02Dep,'Visible','on')
            set(findobj('tag','checkd02'),'Visible','on')
        end


    case 'fitGRAll'
        checkGRA = get(findobj('tag','checkgprAll'),'value');
        if checkGRA==1
            set(findobj('tag','checkcouplingb1'),'value',0);
            set(findobj('tag','checkcouplingb2'),'value',0);
            set(pard0,'Visible','on')
            set(pard0Err,'Visible','off')
            set(pard0Dep,'Visible','off')
            set(findobj('tag','checkd0'),'Visible','off')
            set(pard02,'Visible','on')
            set(pard02Err,'Visible','off')
            set(pard02Dep,'Visible','off')
            set(findobj('tag','checkd02'),'Visible','off')
        else
            set(pard0,'Visible','on')
            set(pard0Err,'Visible','on')
            set(pard0Dep,'Visible','on')
            set(findobj('tag','checkd0'),'Visible','on')
            set(pard02,'Visible','on')
            set(pard02Err,'Visible','on')
            set(pard02Dep,'Visible','on')
            set(findobj('tag','checkd02'),'Visible','on')
        end
            
    
    case 'calc2'
        
        testTc = str2num(get(parTc,'string'));
        testTc2 = str2num(get(parTc2,'string'));
        testd0 = str2num(get(pard0,'string'));
        testd02 = str2num(get(pard02,'string'));
        testc = str2num(get(parc,'string'));
        testc2 = str2num(get(parc2,'string'));
        testlambda = str2num(get(parlambda,'string'));
        testlambda2 = str2num(get(parlambda2,'string'));
        testalpha = str2num(get(paralpha,'string'));
        kappa = str2num(get(parkappa,'string'));
        Aniso = str2num(get(parAniso,'string'));
        trans = str2num(get(partrans,'string'));
        awidth = str2num(get(parwidth,'string'));
        bthick = str2num(get(parthick,'string'));
        calcpoints = str2num(get(parcalcpoints,'string'));
        model5 = get(Anitype,'string');
        model4 = get(Dmtype,'string');
        model2 = get(Bandtype,'string');
        model3 = get(symtype,'string');
        model1 = get(SCtype,'string');
        model = [model1 model2 model3 model4 model5];
        calcline=findobj(f1,'tag','calcline');        
        dataline=findobj(f1,'tag','dataline');
        tdat=get(dataline,'xdata');
        lowesttpoint = min(tdat);
        if lowesttpoint>1
            lowestT = 0.1;
        else
            lowestT = lowesttpoint*0.1;
        end
        tcalc=linspace(lowestT,max([testTc testTc2]),calcpoints);
        if strcmp(model2,'Single')
            jcalc = uiABCalcFunctions(kappa,Aniso,[testTc testd0 testc testlambda],awidth,bthick,tcalc,model,trans);
        elseif strcmp(model2,'LinkRn')         
            jcalc = uiABCalcFunctions(kappa,Aniso,[testTc testd0 testc testlambda testTc2 testd02 testc2],awidth,bthick,tcalc,model,trans);
        elseif strcmp(model2,'Independent')
            jcalc = uiABCalcFunctions(kappa,Aniso,[testTc testd0 testc testlambda testTc2 testd02 testc2 testlambda2],awidth,bthick,tcalc,model,trans);
        elseif strcmp(model2,'LinkaRn')           
            jcalc = uiABCalcFunctions(kappa,Aniso,[testTc testd0 testc testlambda testTc2 testd02 testc2 testalpha],awidth,bthick,tcalc,model,trans);
        else
            set(symtype,'string','Please select model')
        end
            
        
        set(calcline,'xdata',tcalc,'ydata',jcalc)
        
        
    case 'fit2'
        kb = 8.617*10^(-5);  %bolztmannzs
        testTc = str2num(get(parTc,'string'));
        testTc2 = str2num(get(parTc2,'string'));
        testd0 = str2num(get(pard0,'string'));
        testd02 = str2num(get(pard02,'string'));
        testc = str2num(get(parc,'string'));
        testc2 = str2num(get(parc2,'string'));
        testlambda = str2num(get(parlambda,'string'));
        testlambda2 = str2num(get(parlambda2,'string'));
        testalpha = str2num(get(paralpha,'string'));
        kappa = str2num(get(parkappa,'string'));
        Aniso = str2num(get(parAniso,'string'));
        awidth = str2num(get(parwidth,'string'));
        bthick = str2num(get(parthick,'string'));
        iternum = str2num(get(parnumits,'string'));
        tolerance = str2num(get(tolerance,'string'));
        trans = str2num(get(partrans,'string'));
        checktrans = get(findobj('tag','checktrans'),'value');
        checkAniso = get(findobj('tag','checkAniso'),'value');
        checkTc = get(findobj('tag','checkTc'),'value');
        checkTc2 = get(findobj('tag','checkTc2'),'value');
        checkd0 = get(findobj('tag','checkd0'),'value');
        checkd02 = get(findobj('tag','checkd02'),'value');
        checkc = get(findobj('tag','checkc'),'value');
        checkc2 = get(findobj('tag','checkc2'),'value');
        checklambda = get(findobj('tag','checklambda'),'value');
        checklambda2 = get(findobj('tag','checklambda2'),'value');
        checkalpha = get(findobj('tag','checkalpha'),'value');
        checkcoupb1 = get(findobj('tag','checkcouplingb1'),'value');
        checkcoupb2 = get(findobj('tag','checkcouplingb2'),'value');
        checkgprAll = get(findobj('tag','checkgprAll'),'value');
        checksdCC = get(findobj('tag','checksdCC'),'value');
        parGR1 = str2num(get(parGR1,'string'));
        parGR2 = str2num(get(parGR2,'string'));
        gprAllInitial = str2num(get(pargprAll,'string'));
        checkcoupling = [checkcoupb1 checkcoupb2 checksdCC parGR1 parGR2 checkgprAll gprAllInitial];
        model5 = get(Anitype,'string');
        model4 = get(Dmtype,'string');
        model2 = get(Bandtype,'string');
        model3 = get(symtype,'string');
        model1 = get(SCtype,'string');
        model = [model1 model2 model3 model4 model5];
        fitline=findobj(f1,'tag','fitline');
        dataline=findobj(f1,'tag','dataline');
        tdat=get(dataline,'xdata');
        jdat=get(dataline,'ydata');
        if strcmp(model2,'Single')
            sw=[checkTc checkd0 checkc checklambda checktrans];
            sw=~sw;       
            [fitt fitj p resnorm err dep gprAll] = uiABFitFunctions(kappa,Aniso,[testTc testd0 testc testlambda trans],awidth,bthick,tdat,jdat,sw,iternum,model,tolerance,checkcoupling);
            
            set(partrans,'string',num2str(p(5)))
            set(partransErr,'string',num2str(err(5)))
            set(partransDep,'string',num2str(dep(5)))
            
        
        elseif strcmp(model2,'LinkRn')
            sw=[checkTc checkd0 checkc checklambda checkTc2 checkd02 checkc2 checktrans];
            sw=~sw;            
            [fitt fitj p resnorm err dep gprAll] = uiABFitFunctions(kappa,Aniso,[testTc testd0 testc testlambda testTc2 testd02 testc2 trans],awidth,bthick,tdat,jdat,sw,iternum,model,tolerance,checkcoupling);
            
            set(parTc2,'string',num2str(p(5)))
            set(parTc2Err,'string',num2str(err(5)))
            set(parTc2Dep,'string',num2str(dep(5)))

            set(pard02,'string',num2str(p(6)))
            set(pard02Err,'string',num2str(err(6)))
            set(pard02Dep,'string',num2str(dep(6)))

            set(parc2,'string',num2str(p(7)))
            set(parc2Err,'string',num2str(err(7)))
            set(parc2Dep,'string',num2str(dep(7)))

            set(partrans,'string',num2str(p(8)))
            set(partransErr,'string',num2str(err(8)))
            set(partransDep,'string',num2str(dep(8)))
            
            set(pargprAll,'string',num2str(gprAll(1)))
            set(pargprAllErr,'string',num2str(gprAll(2)))
            set(pargprAllDep,'string',num2str(gprAll(3)))
            
            set(findobj('tag','parGR2'),'string',num2str(2*p(6)/(kb*p(5))))

            
        elseif strcmp(model2,'Independent')
            sw=[checkTc checkd0 checkc checklambda checkTc2 checkd02 checkc2 checklambda2 checktrans];
            sw=~sw;
            [fitt fitj p resnorm err dep gprAll] = uiABFitFunctions(kappa,Aniso,[testTc testd0 testc testlambda testTc2 testd02 testc2 testlambda2 trans],awidth,bthick,tdat,jdat,sw,iternum,model,tolerance,checkcoupling);
            
            set(parTc2,'string',num2str(p(5)))
            set(parTc2Err,'string',num2str(err(5)))
            set(parTc2Dep,'string',num2str(dep(5)))

            set(pard02,'string',num2str(p(6)))
            set(pard02Err,'string',num2str(err(6)))
            set(pard02Dep,'string',num2str(dep(6)))

            set(parc2,'string',num2str(p(7)))
            set(parc2Err,'string',num2str(err(7)))
            set(parc2Dep,'string',num2str(dep(7)))
            
            set(parlambda2,'string',num2str(p(8)))
            set(parlambda2Err,'string',num2str(err(8)))
            set(parlambda2Dep,'string',num2str(dep(8)))
            
            set(partrans,'string',num2str(p(9)))
            set(partransErr,'string',num2str(err(9)))
            set(partransDep,'string',num2str(dep(9)))
            
            set(pargprAll,'string',num2str(gprAll(1)))
            set(pargprAllErr,'string',num2str(gprAll(2)))
            set(pargprAllDep,'string',num2str(gprAll(3)))
            
            set(findobj('tag','parGR2'),'string',num2str(2*p(6)/(kb*p(5))))
                       
        elseif strcmp(model2,'LinkaRn')
            sw=[checkTc checkd0 checkc checklambda checkTc2 checkd02 checkc2 checkalpha checktrans];
            sw=~sw;            
            [fitt fitj p resnorm err dep gprAll] = uiABFitFunctions(kappa,Aniso,[testTc testd0 testc testlambda testTc2 testd02 testc2 testalpha trans],awidth,bthick,tdat,jdat,sw,iternum,model,tolerance,checkcoupling);
            
            set(parTc2,'string',num2str(p(5)))
            set(parTc2Err,'string',num2str(err(5)))
            set(parTc2Dep,'string',num2str(dep(5)))

            set(pard02,'string',num2str(p(6)))
            set(pard02Err,'string',num2str(err(6)))
            set(pard02Dep,'string',num2str(dep(6)))

            set(parc2,'string',num2str(p(7)))
            set(parc2Err,'string',num2str(err(7)))
            set(parc2Dep,'string',num2str(dep(7)))
            
            set(paralpha,'string',num2str(p(8)))
            set(paralphaErr,'string',num2str(err(8)))
            set(paralphaDep,'string',num2str(dep(8)))
            
            set(partrans,'string',num2str(p(9)))
            set(partransErr,'string',num2str(err(9)))
            set(partransDep,'string',num2str(dep(9)))
            
            set(pargprAll,'string',num2str(gprAll(1)))
            set(pargprAllErr,'string',num2str(gprAll(2)))
            set(pargprAllDep,'string',num2str(gprAll(3)))
            
            set(findobj('tag','parGR2'),'string',num2str(2*p(6)/(kb*p(5))))
            
        else
            set(symtype,'string','Please select model')
        end
        set(fitline,'xdata',fitt,'ydata',fitj)
        
        set(parTc,'string',num2str(p(1)))
        set(parTcErr,'string',num2str(err(1)))
        set(parTcDep,'string',num2str(dep(1)))
        
        set(pard0,'string',num2str(p(2)))
        set(pard0Err,'string',num2str(err(2)))
        set(pard0Dep,'string',num2str(dep(2)))
        
        set(parc,'string',num2str(p(3)))
        set(parcErr,'string',num2str(err(3)))
        set(parcDep,'string',num2str(dep(3)))
        
        set(parlambda,'string',num2str(p(4)))
        set(parlambdaErr,'string',num2str(err(4)))
        set(parlambdaDep,'string',num2str(dep(4)))
        
        set(findobj('tag','parGR1'),'string',num2str(2*p(2)/(kb*p(1))))
        
        set(findobj('tag','parRs'),'string',num2str(resnorm))
        
    end

end
return


function [tdat jdat] = readsfjc(filename)

mvec = csvread(filename);

tdat = mvec(:,1);
jdat = mvec(:,2);

return

function a = interlace( a, x, fix )
a(~fix) = x;
return

function [tdat jvec p R err dep gpr] = uiABFitFunctions(kappa,Aniso,pint,a2,b2,tdat,jdat,sw,numofits,fitmodel,tolerance,couplingvec)

coupling1 = couplingvec(1);
coupling2 = couplingvec(2);
csame = couplingvec(3);
ratio1 = couplingvec(4);
ratio2 = couplingvec(5);
couplingfitsame = couplingvec(6);
couplingfitinitial = couplingvec(7);


gpr = [1 0 0];

if csame==1
    if ~isempty(strfind( fitmodel , 'Independent' )) || ~isempty(strfind( fitmodel , 'LinkaRn' )) || ~isempty(strfind( fitmodel , 'LinkRn' ))
        sw(7) = 1;
    end
    cn2 = 3;
else
    cn2 = 7;
end

%lengths
awidth = a2/2;
bthick = b2/2;
% constants
kb = 8.617*10^(-5);  %bolztmannzs
fluxq = 2.067833758*10^(-15); %flux quantum
mew0 = 4*pi*10^(-7); % Vacuum permeability
kap = log(kappa)+0.5; %kappa reduced
echarge = 1;%1.60217662*10^-19; %electron charge
nmax = 10000;
%determine what a is depending on d or s wave
if ~isempty(strfind( fitmodel , 'Dwave' ))
    a = 7/5;
elseif ~isempty(strfind( fitmodel , 'Swave' ))
    a = 2/3;
end
gpr1 = 1;
gpr2 = 1;
coup1 = 2;
coup2 = 6;
dlow = 10^-8;
dhigh = 1;
% if weakcoupling set fitting gaps to zero
if couplingfitsame==1
    dlow = 0.1;
    dhigh = 10;
    sw(2) = 0;
    sw(6) = 1;
    pint(2) = couplingfitinitial;
end

if coupling1==1
    sw(2) = 1;
    coup1 = 1;
    gpr1 = (ratio1/2).*kb;
end
if (coupling2==1) && (~isempty(strfind( fitmodel , 'Independent' )) || ~isempty(strfind( fitmodel , 'LinkaRn' )) || ~isempty(strfind( fitmodel , 'LinkRn' )))
    sw(6) = 1;
    coup2 = 5;
    gpr2 = (ratio2/2).*kb;
end

% functions
g = @(theta)(cos(2.*theta)); %d wave gap symmetry
delta = @(d0,c,Tc,T)(d0.*tanh(((pi.*kb.*Tc)./d0).*sqrt(a.*c.*abs(sign(Tc-T)).*heaviside1(Tc-T).*((Tc./T) - 1)))); %gap function
integrands = @(Tc,d0,c,T,eps) (sech(sqrt( (eps.^(2)) + (delta(d0,c,Tc,T).^(2))  )./(2*kb.*T))).^(2); %integrand s wave
intgs = @(Tc,d0,c,T) integral(@(eps) integrands(Tc,d0,c,T,eps),0.0000001,0.1,'AbsTol',0,'RelTol',1e-10); %integral s wave

% bits in pieces
% (fluxq*kap/(4*pi*mew0))*(1/((p(4)^2)*10^(-18)))
% (1-(1./(2*kb.*T))*intgs(p(1),p(2),p(3),T))
% d wave rho old: (1-(1./(2*pi*kb.*T))*intgd(p(1),p(2),p(3),T)) ---->
% change to: uifitACrho(T,Tc,d0,c,nmax)

if ~isempty(strfind( fitmodel , 'TypeJc' ))
    %determine geomtrey
    if ~isempty(strfind( fitmodel , '2DSample' ))
        factor = (awidth.*bthick.*10^-12);
    elseif ~isempty(strfind( fitmodel , '3DSample' ))
        factor = (awidth.*bthick.*10^-12);
    elseif ~isempty(strfind( fitmodel , 'WireBessel' ))
        factor = (pi.*(awidth./2).^2);
    elseif ~isempty(strfind( fitmodel , 'WireTanh' ))
        factor = (pi.*(awidth./2).^2);
    end
elseif ~isempty(strfind( fitmodel , 'TypeIc' ))
    factor = 1;
end

singlefun = @(p,T) factor.*pi.*delta(p(2),p(3),p(1),T).*tanh(delta(p(2),p(3),p(1),T)./(2.*kb.*T))./(2.*echarge.*p(4));

if couplingfitsame==1
    if ~isempty(strfind( fitmodel , 'LinkRn' ))
        model = @(p,T) p(8).*(singlefun([p(1) (p(2)./2).*kb.*p(1) p(3) p(4)],T) + singlefun([p(5) (p(2)./2).*kb.*p(5) p(cn2) p(4)],T));
    elseif ~isempty(strfind( fitmodel , 'Independent' ))
        model = @(p,T) p(9).*(singlefun([p(1) (p(2)./2).*kb.*p(1) p(3) p(4)],T) + singlefun([p(5) (p(2)./2).*kb.*p(5) p(cn2) p(8)],T));
    elseif ~isempty(strfind( fitmodel , 'LinkaRn' ))    
        model = @(p,T) p(9).*(p(8).*singlefun([p(1) (p(2)./2).*kb.*p(1) p(3) p(4)],T) + (1-p(8)).*singlefun([p(5) (p(2)./2).*kb.*p(5) p(cn2) p(4)],T));
    end
else
    if ~isempty(strfind( fitmodel , 'Single' ))
        model = @(p,T) p(5).*singlefun([p(1) gpr1.*p(coup1) p(3) p(4)],T);
    elseif ~isempty(strfind( fitmodel , 'LinkRn' ))
        model = @(p,T) p(8).*(singlefun([p(1) gpr1.*p(coup1) p(3) p(4)],T) + singlefun([p(5) gpr2.*p(coup2) p(cn2) p(4)],T));
    elseif ~isempty(strfind( fitmodel , 'Independent' ))
        model = @(p,T) p(9).*(singlefun([p(1) gpr1.*p(coup1) p(3) p(4)],T) + singlefun([p(5) gpr2.*p(coup2) p(cn2) p(8)],T));
    elseif ~isempty(strfind( fitmodel , 'LinkaRn' ))    
        model = @(p,T) p(9).*(p(8).*singlefun([p(1) gpr1.*p(coup1) p(3) p(4)],T) + (1-p(8)).*singlefun([p(5) gpr2.*p(coup2) p(cn2) p(4)],T));
    end
end

options = optimset('MaxFunEvals', 50000,'MaxIter', numofits,'TolFun',tolerance,'TolX',1e-40,'Display','iter','Algorithm','trust-region-reflective');

clow = 0.01;
chigh = 5;
startingVals = [pint Aniso]; %guess values
if ~isempty(strfind( fitmodel , 'Single' ))
    lb = [max(tdat)-0.4*max(tdat) dlow clow 10^-40 0]; %lower bound
    ub = [max(tdat)+0.7*max(tdat) dhigh chigh 10^40 1]; %upper bound
    %lb = [max(tdat)-0.4*max(tdat) 0.00001 0.2 0.1 0]; %lower bound
    %ub = [max(tdat)+0.7*max(tdat) 1 5 100000 1]; %upper bound
elseif ~isempty(strfind( fitmodel , 'LinkRn' ))
    lb = [max(tdat)-0.4*max(tdat) dlow clow 10^-40 0.0001 dlow clow 0]; %lower bound
    ub = [max(tdat)+0.7*max(tdat) dhigh chigh 10^40 max(tdat)+1.7*max(tdat) dhigh chigh 1]; %upper bound
elseif ~isempty(strfind( fitmodel , 'Independent' )) 
    %lb = [max(tdat)-0.4*max(tdat) 0.00001 0.2 0.1 0.0001 0.0001 0.2 0.1 0]; %lower bound
    %ub = [max(tdat)+0.7*max(tdat) 1 5 100000 pint(1) 1 5 100000 1]; %upper bound
    lb = [0.0001 dlow clow 10^-40 0.0001 dlow clow 10^-40 0]; %lower bound
    ub = [max(tdat)+1.7*max(tdat) dhigh chigh 10^40 max(tdat)+1.7*max(tdat) dhigh chigh 10^40 1]; %upper bound
elseif ~isempty(strfind( fitmodel , 'LinkaRn' ))
    lb = [0.0001 dlow clow 10^-40 0.0001 dlow clow 0 0]; %lower bound
    ub = [max(tdat)+1.7*max(tdat) dhigh chigh 10^40 max(tdat)+1.7*max(tdat) dhigh chigh 1 1]; %upper bound
    %lb = [0.001 0.00001 0.2 0.1 0.0001 0.0001 0.2 0.0001 0]; %lower bound
    %ub = [max(tdat)+0.7*max(tdat) 1 5 100000 max(tdat)+0.7*max(tdat) 1 5 1 1]; %upper bound
end


[ptmp resnorm residual exitflag output lagrange jacobian] = lsqcurvefit(@(x,tdat) model(interlace(startingVals,x,sw),tdat),startingVals(~sw),tdat,jdat,lb(~sw),ub(~sw),options); %do the fit, takes a while

% Calculate errors in parameters and dependencies
jac = jacobian;
mse = sum(abs(residual).^2)/(size(jac,1)-size(jac,2));
Ca = inv(jac'*jac)*mse;
Cainv = inv(Ca);
errtmp = sqrt(diag(Ca));
deptmp = diag(1-1./(Ca.*Cainv));


dof = sum(~sw);
nn = size(jdat,2);
Rtmp = 1-sum(residual.^2)./sum((0.1.*jdat).^2);
R = 1-(1-Rtmp).*dof./(nn-dof-1);


p = startingVals;
err = [0 0 0 0 0 0 0 0 0 0];
dep = [0 0 0 0 0 0 0 0 0 0];
ii = 1;
for jj = 1:numel(sw)
    if ~sw(jj)==1
        p(jj) = ptmp(ii);
        err(jj) = errtmp(ii);
        dep(jj) = deptmp(ii);
        ii = ii+1;
    end
    
end

fitData = model(p,tdat);
jvec = fitData;

if couplingfitsame==1
    gpr(1) = p(2);
    gpr(2) = err(2);
    gpr(3) = dep(2);
    p(2) = (gpr(1)/2).*kb.*p(1);
    p(6) = (gpr(1)/2).*kb.*p(5);
    err(2) = 0;
    dep(2) = 0;
end
    
    
if coupling1==1
    p(2) = (ratio1/2).*kb.*p(1);
end
if (coupling2==1) && (~isempty(strfind( fitmodel , 'Independent' )) || ~isempty(strfind( fitmodel , 'LinkaRn' )) || ~isempty(strfind( fitmodel , 'LinkRn' )))
    p(6) = (ratio2/2).*kb.*p(5);
end

if csame==1
     if ~isempty(strfind( fitmodel , 'LinkaRn' )) || ~isempty(strfind( fitmodel , 'Independent' )) || ~isempty(strfind( fitmodel , 'LinkRn' ))
        p(7) = p(3);
     end
end


return

function Y = heaviside1(X)
%HEAVISIDE    Step function.
Y = zeros(size(X));
Y(X > 0) = 1;
Y(X == 0) = .5;
return

function jvec = uiABCalcFunctions(kappa,Aniso,p,a2,b2,tdat,fitmodel,trans)

%lengths
awidth = a2/2;
bthick = b2/2;
% constants
kb = 8.617*10^(-5);  %bolztmannzs
fluxq = 2.067833758*10^(-15); %flux quantum
mew0 = 4*pi*10^(-7); % Vacuum permeability
kap = log(kappa)+0.5; %kappa reduced
echarge = 1;%1.60217662*10^-19; %electron charge
nmax = 50000;
%determine what a is depending on d or s wave
if ~isempty(strfind( fitmodel , 'Dwave' ))
    a = 7/5;
elseif ~isempty(strfind( fitmodel , 'Swave' ))
    a = 2/3;
end
% functions
g = @(theta)(cos(2.*theta)); %d wave gap symmetry
delta = @(d0,c,Tc,T)(d0.*tanh(((pi.*kb.*Tc)./d0).*sqrt(a.*c.*abs(sign(Tc-T)).*heaviside1(Tc-T).*((Tc./T) - 1)))); %gap function
integrands = @(Tc,d0,c,T,eps) (sech(sqrt( (eps.^(2)) + (delta(d0,c,Tc,T).^(2))  )./(2*kb.*T))).^(2); %integrand s wave
intgs = @(Tc,d0,c,T) integral(@(eps) integrands(Tc,d0,c,T,eps),0.0000001,0.1,'AbsTol',0,'RelTol',1e-10); %integral s wave





% bits in pieces
% (fluxq*kap/(4*pi*mew0))*(1/((p(4)^2)*10^(-18)))
% (1-(1./(2*kb.*T))*intgs(p(1),p(2),p(3),T))
% d wave rho old: (1-(1./(2*pi*kb.*T))*intgd(p(1),p(2),p(3),T)) ---->
% change to: uifitACrho(T,Tc,d0,c,nmax)

if ~isempty(strfind( fitmodel , 'TypeJc' ))
    %determine geomtrey
    if ~isempty(strfind( fitmodel , '2DSample' ))
        factor = (awidth.*bthick.*10^-12);
    elseif ~isempty(strfind( fitmodel , '3DSample' ))
        factor = (awidth.*bthick.*10^-12);
    elseif ~isempty(strfind( fitmodel , 'WireBessel' ))
        factor = (pi.*(awidth./2).^2);
    elseif ~isempty(strfind( fitmodel , 'WireTanh' ))
        factor = (pi.*(awidth./2).^2);
    end
elseif ~isempty(strfind( fitmodel , 'TypeIc' ))
    factor = 1;
end

singlefun = @(p,T) factor.*pi.*delta(p(2),p(3),p(1),T).*tanh(delta(p(2),p(3),p(1),T)./(2.*kb.*T))./(2.*echarge.*p(4));

%determine model

if ~isempty(strfind( fitmodel , 'Single' ))
    model = @(p,T) trans.*singlefun([p(1) p(2) p(3) p(4)],T);
elseif ~isempty(strfind( fitmodel , 'LinkRn' ))
    model = @(p,T) trans.*(singlefun([p(1) p(2) p(3) p(4)],T) + singlefun([p(5) p(6) p(7) p(4)],T));
elseif ~isempty(strfind( fitmodel , 'Independent' ))
    model = @(p,T) trans.*(singlefun([p(1) p(2) p(3) p(4)],T) + singlefun([p(5) p(6) p(7) p(8)],T));
elseif ~isempty(strfind( fitmodel , 'LinkaRn' ))    
    model = @(p,T) trans.*(p(8).*singlefun([p(1) p(2) p(3) p(4)],T) + (1-p(8)).*singlefun([p(5) p(6) p(7) p(4)],T));
end




fitData = model(p,tdat);
jvec = fitData;

return

function EquationString = uifitEqnLegend(SCmtype,Symmtype,Dmmtype,Bandmtype)


if strcmp(Dmmtype,'2DSample')
    str1 = '4ab';
elseif strcmp(Dmmtype,'3DSample')
    str1 = '4ab';
elseif strcmp(Dmmtype,'WireBessel')
    str1 = '\pi a^2';
elseif strcmp(Dmmtype,'WireTanh')
    str1 = '\pi a^2';
end


str2 = '\frac{\pi \Delta(T)}{2 e R_norm} \tanh \left( \frac{ \Delta(T)}{2 k_B T} \right)';
    
str3 = '\Delta(T) = \Delta(0) \tanh \left( \frac{\pi k_B T_c}{\Delta(0)} \sqrt{a \frac{\Delta C}{C} \left( \frac{T_c}{T} - 1 \right) } \right)';
if strcmp(Bandmtype,'Single')
    str4 = '';
elseif strcmp(Bandmtype,'LinkRn')
    str4 = 'J_{ctot} = J_{c1} + J_{c2}, R_{norm1} = R_{norm2}';
elseif strcmp(Bandmtype,'Independent')
    str4 = 'J_{ctot} = J_{c1} + J_{c2}';
elseif strcmp(Bandmtype,'LinkaRn')
    str4 = 'J_{ctot} = \alpha J_{c1} + (1-\alpha) J_{c2}, R_{norm1} = R_{norm2}';
else 
    str4 = '';
end



EquationString = ['$$ J_c(T,sf) = ' str1 str2 ', ' str3 ', ' str4 ' $$'];

return