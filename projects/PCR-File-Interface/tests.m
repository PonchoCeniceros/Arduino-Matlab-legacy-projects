% https://regexr.com/  

function main()
    import java.util.ArrayList

    pcr_data = reading_pcr('testData/922S.pcr');
    disp(size(pcr_data));
    idx = get_global_params(pcr_data);
    get_phases(idx, pcr_data);
end
%% 
function get_phases(idx, pcr_data)
    % Acomodar los datos:
    % Profile Parameters for Pattern
    Nat = []; Dis = []; Ang = [];
    Pr1 = []; Pr2 = []; Pr3 = [];
    Jbt = []; Irf = []; Isy = [];
    Str = []; Fur = []; ATZ = [];
    Nvk = []; Npr = []; Mor = [];
    % Acomodar los datos:
    % Atom, Typ, X, Y, Z, Biso, Occ, In, Fin, N_t, SpcCodes
    A = []; T = []; X = []; Y = []; Z = []; B = [];
    O = []; I = []; F = []; N = []; S = [];    
    % Acomodar los datos:
    % Profile Parameters for Pattern
    SUAP = []; SVBP = []; BWCA = []; SXAA = [];
    SYBA = []; SGGA = []; SLS  = []; SD   = [];    
    
    while idx < size(pcr_data) - 1
        
        line = pcr_data.get(idx);
%         [r, s] = regexp(line, ' (-)*([0-9]+)\.*([0-9]*)');
%         disp(line(r(1):s(1))); % fase       
%         disp(line(r(3):s(3))); % R_Bragg       
        idx = idx + 1;
        
        line = pcr_data.get(idx);
        A = [A; {''}]; 
        T = [T; {''}]; X = [X; {''}];
        Y = [Y; {''}]; Z = [Z; {''}]; B = [B; {''}]; O = [O; {''}];
        I = [I; {''}]; F = [F; {''}]; N = [N; {''}]; S = [S; {''}];
        SUAP = [SUAP; {''}]; SVBP = [SVBP; {''}];
        BWCA = [BWCA; {''}]; SXAA = [SXAA; {''}];
        SYBA = [SYBA; {''}]; SGGA = [SGGA; {''}];
        SLS  = [SLS;  {''}]; SD   = [SD;   {''}];        
        idx = idx + 1;
        
        line = pcr_data.get(idx);
        [r, s] = regexp(line, ' (-)*([0-9]+)\.*([0-9]*)');
        Nat = [Nat; {line(r(1):s(1))}];
        Dis = [Dis; {line(r(2):s(2))}];
        Ang = [Ang; {line(r(3):s(3))}];
        Pr1 = [Pr1; {line(r(4):s(4))}];
        Pr2 = [Pr2; {line(r(5):s(5))}];
        Pr3 = [Pr3; {line(r(6):s(6))}];
        Jbt = [Jbt; {line(r(7):s(7))}];
        Irf = [Irf; {line(r(8):s(8))}];
        Isy = [Isy; {line(r(9):s(9))}];
        Str = [Str; {line(r(10):s(10))}];
        Fur = [Fur; {line(r(11):s(11))}];
        ATZ = [ATZ; {line(r(12):s(12))}];
        Nvk = [Nvk; {line(r(13):s(13))}];
        Npr = [Npr; {line(r(14):s(14))}];
        Mor = [Mor; {line(r(15):s(15))}];
        
        idx = idx + 2;
        line = pcr_data.get(idx);        
       % extraer los datos de las lineas
        while regexp(line, ' +[A-Z]+')
            % extraer el elemento quimico
            [i, j]  = regexp(line, '[A-Z]+[a-z]*[1-9]*');
            % colocar el elemento quimico en la tabla
            A = [A; {line(i:j)}];        
            % extraer el tipo de elemento
            [i, j]  = regexp(line, ' +[A-Z]+');
            % colocar el tipo de elemento en la tabla
            T = [T; {line(i:j)}];
            % extraer los parametros asociados:
            % X, Y, Z, Biso, Occ, In, Fin, N_t, Spc/Codes
            [r, s]  = regexp(line, ' (-)*([0-9]+)\.*([0-9]*)');
            % colocar los parametros extraidos en la tabla
            X  = [X; {line(r(1):s(1))}];
            Y  = [Y; {line(r(2):s(2))}];
            Z  = [Z; {line(r(3):s(3))}];
            B  = [B; {line(r(4):s(4))}];
            O  = [O; {line(r(5):s(5))}];
            I  = [I; {line(r(6):s(6))}];
            F  = [F; {line(r(7):s(7))}];
            N  = [N; {line(r(8):s(8))}];
            S  = [S; {line(r(9):s(9))}];
            % pasar a la siguiente linea
            idx  = idx + 1;
            line = pcr_data.get(idx);       
            % extraer los parametros asociados:
            % X, Y, Z, Biso, Occ        
            [p, q] = regexp(line, ' (-)*([0-9]+)\.*([0-9]*)');
            % colocar los parametros extraidos en la tabla
            X  = [X; {line(p(1):q(1))}];
            Y  = [Y; {line(p(2):q(2))}];
            Z  = [Z; {line(p(3):q(3))}];
            B  = [B; {line(p(4):q(4))}];
            O  = [O; {line(p(5):q(5))}];         
            % colocar los parametros extraidos en la tabla
            A  = [A; {' '}];
            T  = [T; {' '}];
            I  = [I; {' '}];
            F  = [F; {' '}];
            N  = [N; {' '}];
            S  = [S; {' '}];
            % pasar a la siguiente linea
            idx  = idx + 1;
            line = pcr_data.get(idx);
        end

        line = pcr_data.get(idx);
        [i, j] = regexp(line, '(-)*([0-9]*)\.*([0-9]*)[E\-[0-9]+]?');

        SUAP = [SUAP; {strcat(line(i(1):j(1)), line(i(2):j(2)))}];
        SVBP = [SVBP; {line(i(3):j(3))}];
        BWCA = [BWCA; {line(i(4):j(4))}];
        SXAA = [SXAA; {line(i(5):j(5))}];
        SYBA = [SYBA; {line(i(6):j(6))}];
        SGGA = [SGGA; {line(i(7):j(7))}];
        SLS  = [SLS;  {line(i(8):j(8))}];
        SD   = [SD;   {''}];

        idx = idx + 1;
        line = pcr_data.get(idx);
        [i, j] = regexp(line, '(-)*([0-9]+)\.*([0-9]*)');

        SUAP = [SUAP; {line(i(1):j(1))}];
        SVBP = [SVBP; {line(i(2):j(2))}];
        BWCA = [BWCA; {line(i(3):j(3))}];
        SXAA = [SXAA; {line(i(4):j(4))}];
        SYBA = [SYBA; {line(i(5):j(5))}];
        SGGA = [SGGA; {line(i(6):j(6))}];
        SLS  = [SLS;  {''}];
        SD   = [SD;   {''}];

        idx = idx + 1;
        line = pcr_data.get(idx);
        [i, j] = regexp(line, '(-)*([0-9]+)\.*([0-9]*)');

        SUAP = [SUAP; {line(i(1):j(1))}];
        SVBP = [SVBP; {line(i(2):j(2))}];
        BWCA = [BWCA; {line(i(3):j(3))}];
        SXAA = [SXAA; {line(i(4):j(4))}];
        SYBA = [SYBA; {line(i(5):j(5))}];
        SGGA = [SGGA; {line(i(6):j(6))}];
        SLS  = [SLS;  {line(i(7):j(7))}];
        SD   = [SD;   {line(i(8):j(8))}];   

        idx = idx + 1;
        line = pcr_data.get(idx);
        [i, j] = regexp(line, '(-)*([0-9]+)\.*([0-9]*)');

        SUAP = [SUAP; {line(i(1):j(1))}];
        SVBP = [SVBP; {line(i(2):j(2))}];
        BWCA = [BWCA; {line(i(3):j(3))}];
        SXAA = [SXAA; {line(i(4):j(4))}];
        SYBA = [SYBA; {line(i(5):j(5))}];
        SGGA = [SGGA; {line(i(6):j(6))}];
        SLS  = [SLS;  {line(i(7):j(7))}];
        SD   = [SD;   {''}];    

        idx = idx + 1;
        line = pcr_data.get(idx);
        [i, j] = regexp(line, '(-)*([0-9]+)\.*([0-9]*)');

        SUAP = [SUAP; {line(i(1):j(1))}];
        SVBP = [SVBP; {line(i(2):j(2))}];
        BWCA = [BWCA; {line(i(3):j(3))}];
        SXAA = [SXAA; {line(i(4):j(4))}];
        SYBA = [SYBA; {line(i(5):j(5))}];
        SGGA = [SGGA; {line(i(6):j(6))}];
        SLS  = [SLS;  {''}];
        SD   = [SD;   {''}];    

        idx = idx + 1;
        line = pcr_data.get(idx);
        [i, j] = regexp(line, '(-)*([0-9]+)\.*([0-9]*)');

        SUAP = [SUAP; {line(i(1):j(1))}];
        SVBP = [SVBP; {line(i(2):j(2))}];
        BWCA = [BWCA; {line(i(3):j(3))}];
        SXAA = [SXAA; {line(i(4):j(4))}];
        SYBA = [SYBA; {line(i(5):j(5))}];
        SGGA = [SGGA; {line(i(6):j(6))}];
        SLS  = [SLS;  {''}];
        SD   = [SD;   {''}];    

        idx = idx + 1;
        line = pcr_data.get(idx);
        [i, j] = regexp(line, '(-)*([0-9]+)\.*([0-9]*)');

        SUAP = [SUAP; {line(i(1):j(1))}];
        SVBP = [SVBP; {line(i(2):j(2))}];
        BWCA = [BWCA; {line(i(3):j(3))}];
        SXAA = [SXAA; {line(i(4):j(4))}];
        SYBA = [SYBA; {line(i(5):j(5))}];
        SGGA = [SGGA; {line(i(6):j(6))}];
        SLS  = [SLS;  {line(i(7):j(7))}];
        SD   = [SD;   {line(i(8):j(8))}];    

        idx = idx + 1;
        line = pcr_data.get(idx);
        [i, j] = regexp(line, '(-)*([0-9]+)\.*([0-9]*)');

        SUAP = [SUAP; {line(i(1):j(1))}];
        SVBP = [SVBP; {line(i(2):j(2))}];
        BWCA = [BWCA; {line(i(3):j(3))}];
        SXAA = [SXAA; {line(i(4):j(4))}];
        SYBA = [SYBA; {line(i(5):j(5))}];
        SGGA = [SGGA; {line(i(6):j(6))}];
        SLS  = [SLS;  {line(i(7):j(7))}];
        SD   = [SD;   {line(i(8):j(8))}];    
        
        idx = idx + 1;
    end
    params_table = [Nat, Dis, Ang, Pr1, Pr2, Pr3, Jbt, ...
                    Irf, Isy, Str, Fur, ATZ, Nvk, Npr, Mor];
    sgs_table = [A, T, X, Y, Z, B, O, I, F, N, S];        
    profile_table = [SUAP, SVBP, BWCA, SXAA, SYBA, SGGA, SLS, SD];    
    
    disp(params_table);
    disp(sgs_table);
    disp(profile_table);
end

%%
function pcr_data = reading_pcr(directory)
    import java.util.ArrayList
    pcr_data  = ArrayList;
    pattern = '([0-9]+)\s*!|';
    
%     cnt = 0;
    
    for i = 0:9
        pattern = strcat(pattern, '(-)*([0-9]+)\.*([0-9]*)\s*');
    end
    pattern = strcat(pattern, '|[A-Z]+[0-9]*[A-Z]*');
    
    fid = fopen(directory);
    tline = fgetl(fid);    

    while ischar(tline)
        if regexp(tline, pattern)
            if regexp(tline, '!Number of refined parameters')
                pcr_data.add(tline);
%                 tline = strcat(strcat(num2str(cnt), ': '),  tline);
%                 disp(tline);
%                 cnt = cnt + 1;
            end
            if regexp(tline, 'Data for PHASE number:')
                pcr_data.add(tline);
%                 tline = strcat(strcat(num2str(cnt), ': '),  tline);
%                 disp(tline);
%                 cnt = cnt + 1;            
            end            
            if isempty(regexp(tline, '!', 'once'))
                pcr_data.add(tline);
%                 tline = strcat(strcat(num2str(cnt), ': '),  tline);
%                 disp(tline);
%                 cnt = cnt + 1;
            end
        end
        tline = fgetl(fid);
    end
    fclose(fid);
end

function idx = get_global_params(pcr_data)
    idx = 1;
    % Job, Npr,...
    line = pcr_data.get(idx);
%     [i, j] = regexp(line, '(-)*([0-9]+)\.*([0-9]*)');
    % colocar parametros de la linea extraída en sus posiciones
    disp(line);
    idx = idx + 1;
    % Ipr, Ppr,...
    line = pcr_data.get(idx);
    if isempty(regexp(line, '(-)*([0-9]+)\.*([0-9]*)', 'once'))
        disp(line);
        idx = idx + 1;
        line = pcr_data.get(idx);
        disp(line);
        idx = idx + 1;
    else
%         [i, j] = regexp(line, '(-)*([0-9]+)\.*([0-9]*)')
        % colocar parametros de la linea extraída en sus posiciones
        disp(line);        
        idx = idx + 1;
    end
    % Lambda1,...
    line = pcr_data.get(idx);
%     [i, j] = regexp(line, '(-)*([0-9]+)\.*([0-9]*)');
    % colocar parametros de la linea extraída en sus posiciones
    disp(line);
    idx = idx + 1;
    % NCY, Eps,...
    line = pcr_data.get(idx);
%     [i, j] = regexp(line, '(-)*([0-9]+)\.*([0-9]*)');
    % colocar parametros de la linea extraída en sus posiciones
    disp(line);
    idx = idx + 1;
    % Number of refined parameters
    line = pcr_data.get(idx);
%     [i, j] = regexp(line, '(-)*([0-9]+)\.*([0-9]*)');
    % colocar parametros de la linea extraída en sus posiciones
    disp(line);
    idx = idx + 1;
    % Zero, Code,...
    line = pcr_data.get(idx);
%     [i, j] = regexp(line, '(-)*([0-9]+)\.*([0-9]*)');
    % colocar parametros de la linea extraída en sus posiciones
    disp(line);
    idx = idx + 1;
    % Background coefficients 1
    line = pcr_data.get(idx);
%     [i, j] = regexp(line, '(-)*([0-9]+)\.*([0-9]*)');
    % colocar parametros de la linea extraída en sus posiciones
    disp(line);
    idx = idx + 1;
    % Background coefficients 2
    line = pcr_data.get(idx);
%     [i, j] = regexp(line, '(-)*([0-9]+)\.*([0-9]*)');
    % colocar parametros de la linea extraída en sus posiciones
    disp(line);
    idx = idx + 1;
end

% 0:COMM 922S
% 1:   0   0   2   0   0   0   1   1   0   0   0   1   0   0   0   0   0   0   1
% 2:   0   0   1   0   1   0   4   0   0  -3  10  -2   0   0   0   1   0
% 3: 1.540560 1.544390  0.50000   50.000 10.0000  0.7998  0.0000   40.00    0.0000  0.0000
% 4:  1  0.25  0.95  0.95  0.95  0.95     20.1950   0.030014    79.9850   0.000   0.000
% 5:       8    !Number of refined parameters
% 6:  0.00000    0.0  0.00000    0.0  0.00000    0.0 0.000000    0.00   0
% 7:      80.000       0.000       0.000       0.000       0.000       0.000
% 8:        0.00        0.00        0.00        0.00        0.00        0.00

%% pasar del 9 al 27

% 9:!  Data for PHASE number:   1  ==> Current R_Bragg for Pattern#  1:  38.7809
% 10:CuFeO3
% 11:   3   0   0 0.0 1.0 2.0   0   0   0   0   0      58489.520   0   7   0
% 12:166                      <--Space group symbol
% 13:Cu     Cu      0.00000  0.00000  0.00000  0.00000   1.00000   0   0   0    0
% 14:                  0.00     0.00     0.00     0.00      0.00
% 15:Fe     Fe      0.00000  0.00000  0.50000  0.00000   1.00000   0   0   0    0
% 16:                  0.00     0.00     0.00     0.00      0.00
% 17:O      O       0.00000  0.00000  0.11100  0.00000   1.00000   0   0   0    0
% 18:                  0.00     0.00     0.00     0.00      0.00


% 19: 0.64525E-05   0.00000   4.63453   0.00000   0.00000   0.00000       0
% 20:     0.00000     0.000     0.000     0.000     0.000     0.000
% 21:   0.000000   0.000000   0.000000   0.000000   1.159165   0.086768   0.000000    0
% 22:      0.000      0.000      0.000      0.000     41.000     51.000      0.000
% 23:   3.027810   3.027810  17.093611  90.000000  90.000000 120.000000
% 24:    0.00000    0.00000    0.00000    0.00000    0.00000    0.00000
% 25:  0.75351  0.00000 -0.05433 -0.01044  0.00000  0.00000  0.00000  0.00000
% 26:    21.00     0.00     0.00     0.00     0.00     0.00     0.00     0.00




% 27:!  Data for PHASE number:   2  ==> Current R_Bragg for Pattern#  1:  73.9668
% 28:TiO2
% 29:   2   0   0 0.0 0.0 1.0   0   0   0   0   0       8174.899   0   7   0
% 30:141                      <--Space group symbol
% 31:Ti     Ti      0.00000  0.00000  0.00000  0.00000   1.00000   0   0   0    0
% 32:                  0.00     0.00     0.00     0.00      0.00
% 33:O      O       0.00000  0.00000  0.17750  0.00000   1.00000   0   0   0    0
% 34:                  0.00     0.00     0.00     0.00      0.00
% 35: 0.17247E-04   0.00000  28.05294   0.00000   0.00000   0.00000       0
% 36:    11.00000     0.000    61.000     0.000     0.000     0.000
% 37:   0.000000   0.210264   0.000000   0.000000   1.159165   0.086768   0.000000    0
% 38:      0.000     71.000      0.000      0.000     41.000     51.000      0.000
% 39:   3.781046   3.781046   9.505918  90.000000  90.000000  90.000000
% 40:   31.00000   31.00000   81.00000    0.00000    0.00000    0.00000
% 41:  0.75351  0.00000 -0.05433 -0.01044  0.00000  0.00000  0.00000  0.00000
% 42:    21.00     0.00     0.00     0.00     0.00     0.00     0.00     0.00

% 43:      20.195      79.985       1

%% campos

%%!        Scale       Shape1      Bov      Str1      Str2       Str3     Strain-Model
% 19: 0.64525E-05   0.00000   4.63453   0.00000   0.00000     0.00000          0
% 20:     0.00000     0.000     0.000     0.000     0.000       0.000
%%!          U           V          W         X         Y        GauSiz      LorSiz      Size-Model
% 21:   0.000000   0.000000   0.000000   0.000000   1.159165   0.086768   0.000000         0
% 22:      0.000      0.000      0.000      0.000     41.000     51.000      0.000
%%!          a           b          c       alpha      beta       gamma      #Cell Info
% 23:   3.027810   3.027810  17.093611  90.000000  90.000000  120.000000
% 24:    0.00000    0.00000    0.00000    0.00000    0.00000     0.00000
%%!        Pref1       Pref2      Asy1       Asy2       Asy3       Asy4        S_L          D_L
% 25:   0.75351     0.00000   -0.05433   -0.01044    0.00000     0.00000   0.00000      0.00000
% 26:     21.00       0.00        0.00       0.00       0.00        0.00     0.00          0.00