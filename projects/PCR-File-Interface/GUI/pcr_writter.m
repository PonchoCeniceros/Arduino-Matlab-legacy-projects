%% --- INTERFÁZ PARA MANIPULAR ARCHIVOS .PCR
%  --- Giovanny Alfonso Chávez Ceniceros
%  --- Julio 2020
function varargout = pcr_writter(varargin)
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @pcr_writter_OpeningFcn, ...
                       'gui_OutputFcn',  @pcr_writter_OutputFcn, ...
                       'gui_LayoutFcn',  [] , ...
                       'gui_Callback',   []);
    if nargin && ischar(varargin{1})
        gui_State.gui_Callback = str2func(varargin{1});
    end

    if nargout
        [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
    else
        gui_mainfcn(gui_State, varargin{:});
    end
end

%% --- CONSTRUCTOR
function pcr_writter_OpeningFcn(hObject, eventdata, handles, varargin)
    handles.output = hObject;
    guidata(hObject, handles);
end

%% --- DESTRUCTOR
function varargout = pcr_writter_OutputFcn(hObject, eventdata, handles) 
    varargout{1} = handles.output;
end

%% --- EXTRAYENDO DATOS DEL ARCHIVO .PCR
function pcr_data = reading_pcr(filename)
    import java.util.ArrayList
    pcr_data  = ArrayList;
    
    % construccion del patron para filtar solo las lineas con numeros
    pattern = '([0-9]+)\s*!|';
    for i = 0:9
        pattern = strcat(pattern, '(-)*([0-9]+)\.*([0-9]*)\s*');
    end
    pattern = strcat(pattern, '|[A-Z]+[0-9]*[A-Z]*');
    
    % extraer el archivo .pcr
    fileID = fopen(filename);
    tline  = fgetl(fileID);
    
    % extraer linea por linea y cerrar el archivo
    while ischar(tline)
        if regexp(tline, pattern)
            % filtrando la linea de refined params
            if regexp(tline, '!Number of refined parameters')
                pcr_data.add(tline);
            end
            % extrayendo las lineas de las fases
            if regexp(tline, 'Data for PHASE number:')
                pcr_data.add(tline);         
            end
            % excluyendo los comentarios con !
            if isempty(regexp(tline, '!', 'once'))
                pcr_data.add(tline);
            end
        end
        tline = fgetl(fileID);
    end
    % cerrando el archivo .pcr
    fclose(fileID);
end

%% --- EXTRAYENDO PARAMETROS GLOBALES
function idx = get_global_params(pcr_data, handles)
    idx = 1;
    % Job, Npr,...
    line = pcr_data.get(idx);
    [i, j] = regexp(line, '(-)*([0-9]+)\.*([0-9]*)');
    % colocar parametros de la linea extraída en sus posiciones
    set(handles.editJob, 'String', line(i(1):j(1)));
    set(handles.editNpr, 'String', line(i(2):j(2)));
    set(handles.editNph, 'String', line(i(3):j(3)));
    set(handles.editNba, 'String', line(i(4):j(4)));
    set(handles.editNex, 'String', line(i(5):j(5)));
    set(handles.editNsc, 'String', line(i(6):j(6)));
    set(handles.editNor, 'String', line(i(7):j(7)));
    set(handles.editDum, 'String', line(i(8):j(8)));
    set(handles.editIwg, 'String', line(i(9):j(9)));
    set(handles.editIlo, 'String', line(i(10):j(10)));
    set(handles.editLas, 'String', line(i(11):j(11)));
    set(handles.editRes, 'String', line(i(12):j(12)));
    set(handles.editSte, 'String', line(i(13):j(13)));
    set(handles.editNre, 'String', line(i(14):j(14)));
    set(handles.editCry, 'String', line(i(15):j(15)));
    set(handles.editUni, 'String', line(i(16):j(16)));
    set(handles.editCor, 'String', line(i(17):j(17)));
    set(handles.editOpt, 'String', line(i(18):j(18)));
    set(handles.editAut, 'String', line(i(19):j(19)));
    idx = idx + 1;
    
    % Ipr, Ppr,...
    line = pcr_data.get(idx);
    if isempty(regexp(line, '(-)*([0-9]+)\.*([0-9]*)', 'once'))
        disp(line);
        set(handles.irfFileLine, 'String', line);
        idx = idx + 1;
        % colocar parametros de la linea extraída en sus posiciones
        line = pcr_data.get(idx);
        [i, j] = regexp(line, '(-)*([0-9]+)\.*([0-9]*)');
        disp(line(i(10):j(10)));
        set(handles.editIpr, 'String', line(i(1):j(1)));
        set(handles.editPpl, 'String', line(i(2):j(2)));
        set(handles.editIoc, 'String', line(i(3):j(3)));
        set(handles.editMat, 'String', line(i(4):j(4)));
        set(handles.editPcr, 'String', line(i(5):j(5)));
        set(handles.editLs1, 'String', line(i(6):j(6)));
        set(handles.editLs2, 'String', line(i(7):j(7)));
        set(handles.editLs3, 'String', line(i(8):j(8)));
        set(handles.editNLI, 'String', line(i(9):j(9)));
        set(handles.editPrf, 'String', line(i(10):j(10)));
        set(handles.editIns, 'String', line(i(11):j(11)));
        set(handles.editRpa, 'String', line(i(12):j(12)));
        set(handles.editSym, 'String', line(i(13):j(13)));
        set(handles.editHkl, 'String', line(i(14):j(14)));
        set(handles.editFou, 'String', line(i(15):j(15)));
        set(handles.editSho, 'String', line(i(16):j(16)));
        set(handles.editAna, 'String', line(i(17):j(17))); 
        idx = idx + 1;
    else
        set(handles.irfFileLine, 'String', '!none');
        [i, j] = regexp(line, '(-)*([0-9]+)\.*([0-9]*)');
        % colocar parametros de la linea extraída en sus posiciones
        set(handles.editIpr, 'String', line(i(1):j(1)));
        set(handles.editPpl, 'String', line(i(2):j(2)));
        set(handles.editIoc, 'String', line(i(3):j(3)));
        set(handles.editMat, 'String', line(i(4):j(4)));
        set(handles.editPcr, 'String', line(i(5):j(5)));
        set(handles.editLs1, 'String', line(i(6):j(6)));
        set(handles.editLs2, 'String', line(i(7):j(7)));
        set(handles.editLs3, 'String', line(i(8):j(8)));
        set(handles.editNLI, 'String', line(i(9):j(9)));
        set(handles.editPrf, 'String', line(i(10):j(10)));
        set(handles.editIns, 'String', line(i(11):j(11)));
        set(handles.editRpa, 'String', line(i(12):j(12)));
        set(handles.editSym, 'String', line(i(13):j(13)));
        set(handles.editHkl, 'String', line(i(14):j(14)));
        set(handles.editFou, 'String', line(i(15):j(15)));
        set(handles.editSho, 'String', line(i(16):j(16)));
        set(handles.editAna, 'String', line(i(17):j(17)));        
        idx = idx + 1;
    end

    % Lambda1,...
    line = pcr_data.get(idx);
    [i, j] = regexp(line, '(-)*([0-9]+)\.*([0-9]*)');
    % colocar parametros de la linea extraída en sus posiciones
    set(handles.editLambda1, 'String', line(i(1):j(1)));
    set(handles.editLambda2, 'String', line(i(2):j(2)));
    set(handles.editRatio,   'String', line(i(3):j(3)));
    set(handles.editBkpos,   'String', line(i(4):j(4)));
    set(handles.editWdt,     'String', line(i(5):j(5)));
    set(handles.editCthm,    'String', line(i(6):j(6)));
    set(handles.editmuR,     'String', line(i(7):j(7)));
    set(handles.editAsyLim,  'String', line(i(8):j(8)));
    set(handles.editRpolarz, 'String', line(i(9):j(9)));
    set(handles.edit2ndMuR,  'String', line(i(10):j(10)));
    idx = idx + 1;
    
    % NCY, Eps,...
    line = pcr_data.get(idx);
    [i, j] = regexp(line, '(-)*([0-9]+)\.*([0-9]*)');
    % colocar parametros de la linea extraída en sus posiciones
    set(handles.editNCY,   'String', line(i(1):j(1)));
    set(handles.editEps,   'String', line(i(2):j(2)));
    set(handles.editR_at,  'String', line(i(3):j(3)));
    set(handles.editR_an,  'String', line(i(4):j(4)));
    set(handles.editR_pr,  'String', line(i(5):j(5)));
    set(handles.editR_gl,  'String', line(i(6):j(6)));
    set(handles.editThmin, 'String', line(i(7):j(7)));
    set(handles.editStep,  'String', line(i(8):j(8)));
    set(handles.editThmax, 'String', line(i(9):j(9)));
    set(handles.editPSD,   'String', line(i(10):j(10)));
    set(handles.editSent0, 'String', line(i(11):j(11)));
    idx = idx + 1;
    
    % Number of refined parameters
    line = pcr_data.get(idx);
    [i, j] = regexp(line, '(-)*([0-9]+)\.*([0-9]*)');
    % colocar parametros de la linea extraída en sus posiciones
    set(handles.editRefinedParams, 'String', line(i:j));
    idx = idx + 1;
    
    % Zero, Code,...
    line = pcr_data.get(idx);
    [i, j] = regexp(line, '(-)*([0-9]+)\.*([0-9]*)');
    % colocar parametros de la linea extraída en sus posiciones
    set(handles.editZero,       'String', line(i(1):j(1)));
    set(handles.editCodeZero,   'String', line(i(2):j(2)));    
    set(handles.editSyCos,      'String', line(i(3):j(3)));
    set(handles.editCodeCos,    'String', line(i(4):j(4)));
    set(handles.editSySin,      'String', line(i(5):j(5)));
    set(handles.editCodeSin,    'String', line(i(6):j(6)));
    set(handles.editLambda,     'String', line(i(7):j(7)));
    set(handles.editCodeLambda, 'String', line(i(8):j(8)));
    set(handles.editMORE,       'String', line(i(9):j(9)));
    idx = idx + 1;
    
    % Background coefficients 1
    line = pcr_data.get(idx);
    [i, j] = regexp(line, '(-)*([0-9]+)\.*([0-9]*)');
    % colocar parametros de la linea extraída en sus posiciones
    set(handles.edit1st, 'String', line(i(1):j(1)));
    set(handles.edit2nd, 'String', line(i(2):j(2)));    
    set(handles.edit3rd, 'String', line(i(3):j(3)));
    set(handles.edit4th, 'String', line(i(4):j(4)));
    set(handles.edit5th, 'String', line(i(5):j(5)));
    set(handles.edit6th, 'String', line(i(6):j(6)));
    idx = idx + 1;
    
    % Background coefficients 2
    line = pcr_data.get(idx);
    [i, j] = regexp(line, '(-)*([0-9]+)\.*([0-9]*)');
    % colocar parametros de la linea extraída en sus posiciones
    set(handles.edit1stB, 'String', line(i(1):j(1)));
    set(handles.edit2ndB, 'String', line(i(2):j(2)));    
    set(handles.edit3rdB, 'String', line(i(3):j(3)));
    set(handles.edit4thB, 'String', line(i(4):j(4)));
    set(handles.edit5thB, 'String', line(i(5):j(5)));
    set(handles.edit6thB, 'String', line(i(6):j(6)));
    idx = idx + 1;
end

%% --- EXTRAYENDO LAS FASES DEL MATERIAL
function idx = get_phases(idx, pcr_data, handles)
    % Acomodar los datos:
    % phase number
    phase = [];
    % Profile Parameters for Pattern
    Nat = []; Dis = []; Ang = [];
    Pr1 = []; Pr2 = []; Pr3 = [];
    Jbt = []; Irf = []; Isy = [];
    Str = []; Fur = []; ATZ = [];
    Nvk = []; Npr = []; Mor = [];
    % Atom, Typ, X, Y, Z, Biso, Occ, In, Fin, N_t, SpcCodes
    A = []; T = []; X = []; Y = []; Z = []; B = [];
    O = []; I = []; F = []; N = []; S = [];    
    % Profile Parameters for Pattern
    SUAP = []; SVBP = []; BWCA = []; SXAA = [];
    SYBA = []; SGGA = []; SLS  = []; SD   = [];    
    
    while idx < size(pcr_data) - 1

        line = pcr_data.get(idx);
        phase = [phase; {line}];
        idx = idx + 1;
        
        line = pcr_data.get(idx);
        % marcar los parametros
        Nat = [Nat; {line}];
        Dis = [Dis; {''}]; Ang = [Ang; {''}];
        Pr1 = [Pr1; {''}]; Pr2 = [Pr2; {''}]; Pr3 = [Pr3; {''}];
        Jbt = [Jbt; {''}]; Irf = [Irf; {''}]; Isy = [Isy; {''}];
        Str = [Str; {''}]; Fur = [Fur; {''}]; ATZ = [ATZ; {''}];
        Nvk = [Nvk; {''}]; Npr = [Npr; {''}]; Mor = [Mor; {''}];
        % marcar la tabla de elementos
        A = [A; {'!#'}]; 
        T = [T; {line}]; X = [X; {''}];
        Y = [Y; {''}]; Z = [Z; {''}]; B = [B; {''}]; O = [O; {''}];
        I = [I; {''}]; F = [F; {''}]; N = [N; {''}]; S = [S; {''}];
        % marcar la ultima tabla
        SUAP = [SUAP; {'!#'}]; SVBP = [SVBP; {line}];
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
        
        idx = idx + 1;
        line = pcr_data.get(idx); 
        phase = [phase; {line}];
        
        idx = idx + 1;
        line = pcr_data.get(idx);        
       % extraer los datos de las lineas
        while regexp(line, ' +[A-Z]+')
            % extraer el elemento quimico
            [i, j]  = regexp(line, '[A-Z]+[a-z]*[1-9]*');
            % colocar el elemento quimico en la tabla
            A = [A; {line(i:j)}];        
            % extraer el tipo de elemento
            [i, j]  = regexp(line, ' +[A-Z]+[a-z]*');
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
        % encabezado de las primeras lineas
        SUAP = [SUAP; {'!Scale'}];
        SVBP = [SVBP; {'Shape1'}];
        BWCA = [BWCA; {'Bov'}];
        SXAA = [SXAA; {'Str1'}];
        SYBA = [SYBA; {'Str2'}];
        SGGA = [SGGA; {'Str3'}];
        SLS  = [SLS;  {'Strain-Model'}];
        SD   = [SD;   {''}];        
        % vaciando datos en las tablas temporales
        line = pcr_data.get(idx);
        [i, j] = regexp(line, '(-)*([0-9]*)\.*([0-9]*)[E\-[0-9]+]?');

        SUAP = [SUAP; {strcat(line(i(1):j(1)), line(i(2):j(2)))}];
        SVBP = [SVBP; {line(i(3):j(3))}];
        BWCA = [BWCA; {line(i(4):j(4))}];
        SXAA = [SXAA; {line(i(5):j(5))}];
        SYBA = [SYBA; {line(i(6):j(6))}];
        SGGA = [SGGA; {line(i(7):j(7))}];
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

        % encabezado de las primeras lineas
        SUAP = [SUAP; {'!U'}];
        SVBP = [SVBP; {'V'}];
        BWCA = [BWCA; {'W'}];
        SXAA = [SXAA; {'X'}];
        SYBA = [SYBA; {'Y'}];
        SGGA = [SGGA; {'GauSiz'}];
        SLS  = [SLS;  {'LorSiz'}];
        SD   = [SD;   {'Size-Model'}];    
        % vaciando datos en las tablas temporales          
        
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
        SLS  = [SLS;  {line(i(7):j(7))}];
        SD   = [SD;   {''}];    

        % encabezado de las primeras lineas
        SUAP = [SUAP; {'!a'}];
        SVBP = [SVBP; {'b'}];
        BWCA = [BWCA; {'c'}];
        SXAA = [SXAA; {'alpha'}];
        SYBA = [SYBA; {'beta'}];
        SGGA = [SGGA; {'gamma'}];
        SLS  = [SLS;  {'#Cell Info'}];
        SD   = [SD;   {''}];       
        % vaciando datos en las tablas temporales          
        
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

        % encabezado de las primeras lineas
        SUAP = [SUAP; {'!Pref1'}];
        SVBP = [SVBP; {'Pref2'}];
        BWCA = [BWCA; {'Asy1'}];
        SXAA = [SXAA; {'Asy2'}];
        SYBA = [SYBA; {'Asy3'}];
        SGGA = [SGGA; {'Asy4'}];
        SLS  = [SLS;  {'S_L'}];
        SD   = [SD;   {'D_L'}];    
        % vaciando datos en las tablas temporales          
        
        idx = idx + 1;
        line = pcr_data.get(idx);
        [i, j] = regexp(line, '(-)*([0-9]+)\.*([0-9]*)');
        
        SUAP = [SUAP; {line(i(1):j(1))}];
        SVBP = [SVBP; {line(i(2):j(2))}];
        BWCA = [BWCA; {line(i(3):j(3))}];
        SXAA = [SXAA; {line(i(4):j(4))}];
        SYBA = [SYBA; {line(i(5):j(5))}];
        SGGA = [SGGA; {line(i(6):j(6))}];
        if length(j) < 7
            SLS = [SLS; {''}];
            SD  = [SD;  {''}];
        else
            SLS = [SLS; {line(i(7):j(7))}];
            SD  = [SD;  {line(i(8):j(8))}];
        end
        
        idx = idx + 1;
        line = pcr_data.get(idx);
        [i, j] = regexp(line, '(-)*([0-9]+)\.*([0-9]*)');

        SUAP = [SUAP; {line(i(1):j(1))}];
        SVBP = [SVBP; {line(i(2):j(2))}];
        BWCA = [BWCA; {line(i(3):j(3))}];
        SXAA = [SXAA; {line(i(4):j(4))}];
        SYBA = [SYBA; {line(i(5):j(5))}];
        SGGA = [SGGA; {line(i(6):j(6))}];
        if length(j) < 7
            SLS = [SLS; {''}];
            SD  = [SD;  {''}];
        else
            SLS = [SLS; {line(i(7):j(7))}];
            SD  = [SD;  {line(i(8):j(8))}];
        end    
        
        idx = idx + 1;
    end
    params_table = [Nat, Dis, Ang, Pr1, Pr2, Pr3, Jbt, ...
                    Irf, Isy, Str, Fur, ATZ, Nvk, Npr, Mor];
    sgs_table = [A, T, X, Y, Z, B, O, I, F, N, S];        
    profile_table = [SUAP, SVBP, BWCA, SXAA, SYBA, SGGA, SLS, SD];

    set(handles.phaseTable, 'data', phase);        
    set(handles.paramsTable, 'data', params_table);
    set(handles.SGSTable, 'data', sgs_table);
    set(handles.profileTable, 'data', profile_table);
end

%% --- EXTRAYENDO LOS PARAMETROS FINALES DEL ARCHIVO
function get_final_params(idx, pcr_data, handles)
    line = pcr_data.get(idx);
    [i, j] = regexp(line, '(-)*([0-9]+)\.*([0-9]*)');
    % colocar parametros de la linea extraída en sus posiciones
    set(handles.edit2Th1TOF1, 'String', line(i(1):j(1)));
    set(handles.edit2Th2TOF2, 'String', line(i(2):j(2)));
    set(handles.editPlot, 'String', line(i(3):j(3)));    
end

%% --- ESCRIBIENDO EL NUEVO ARCHIVO .PCR EN BASE A LOS DATOS EXTRAÍDOS
function writing_new_pcr(filename, handles)
    % abrir el archivo .pcr del directorio input_files
    fileID = fopen(filename, 'wt');
    
    fprintf(fileID, '%s\n', get(handles.commLine, 'String'));
    % escribiendo global_params_1
    fprintf(fileID, '%s\n', ...
            '!Job Npr Nph Nba Nex Nsc Nor Dum Iwg Ilo Ias Res Ste Nre Cry Uni Cor Opt Aut');
    line = strcat(get(handles.editJob, 'String'),32, ...
                  get(handles.editNpr, 'String'),32, ...
                  get(handles.editNph, 'String'),32, ...
                  get(handles.editNba, 'String'),32, ...
                  get(handles.editNex, 'String'),32, ...
                  get(handles.editNsc, 'String'),32, ...
                  get(handles.editNor, 'String'),32, ...
                  get(handles.editDum, 'String'),32, ...
                  get(handles.editIwg, 'String'),32, ...
                  get(handles.editIlo, 'String'),32, ...
                  get(handles.editLas, 'String'),32, ...
                  get(handles.editRes, 'String'),32, ...
                  get(handles.editSte, 'String'),32, ...
                  get(handles.editNre, 'String'),32, ...
                  get(handles.editCry, 'String'),32, ...
                  get(handles.editUni, 'String'),32, ...
                  get(handles.editCor, 'String'),32, ...
                  get(handles.editOpt, 'String'),32, ...
                  get(handles.editAut, 'String'));          
    fprintf(fileID, '%s\n', line);
    
    fprintf(fileID, '%s\n', get(handles.irfFileLine, 'String'));
    % escribiendo global_params_2
    fprintf(fileID, '%s\n', ...
        '!Ipr Ppl Ioc Mat Pcr Ls1 Ls2 Ls3 NLI Prf Ins Rpa Sym Hkl Fou Sho Ana');
    line = strcat(get(handles.editIpr, 'String'),32, ...
                  get(handles.editPpl, 'String'),32, ...
                  get(handles.editIoc, 'String'),32, ...
                  get(handles.editMat, 'String'),32, ...
                  get(handles.editPcr, 'String'),32, ...
                  get(handles.editLs1, 'String'),32, ...
                  get(handles.editLs2, 'String'),32, ...
                  get(handles.editLs3, 'String'),32, ...
                  get(handles.editNLI, 'String'),32, ...
                  get(handles.editPrf, 'String'),32, ...
                  get(handles.editIns, 'String'),32, ...
                  get(handles.editRpa, 'String'),32, ...
                  get(handles.editSym, 'String'),32, ...
                  get(handles.editHkl, 'String'),32, ...
                  get(handles.editFou, 'String'),32, ...
                  get(handles.editSho, 'String'),32, ...
                  get(handles.editAna, 'String'));          
    fprintf(fileID, '%s\n', line);
    
    % escribiendo global_params_3
    fprintf(fileID, '%s\n', ...
        '! Lambda1  Lambda2    Ratio    Bkpos    Wdt    Cthm     muR   AsyLim   Rpolarz  2nd-muR -> Patt# 1');
    line = strcat(get(handles.editLambda1, 'String'),32, ...
                  get(handles.editLambda2, 'String'),32, ...
                  get(handles.editRatio, 'String'),32, ...
                  get(handles.editBkpos, 'String'),32, ...
                  get(handles.editWdt, 'String'),32, ...
                  get(handles.editCthm, 'String'),32, ...
                  get(handles.editmuR, 'String'),32, ...
                  get(handles.editAsyLim, 'String'),32, ...
                  get(handles.editRpolarz, 'String'),32, ...
                  get(handles.edit2ndMuR, 'String'));          
    fprintf(fileID, '%s\n', line);
    
    % escribiendo global_params_4
    fprintf(fileID, '%s\n', ...
        '!NCY  Eps  R_at  R_an  R_pr  R_gl     Thmin       Step       Thmax    PSD    Sent0');
    line = strcat(get(handles.editNCY, 'String'),32, ...
                  get(handles.editEps, 'String'),32, ...
                  get(handles.editR_at, 'String'),32, ...
                  get(handles.editR_an, 'String'),32, ...
                  get(handles.editR_pr, 'String'),32, ...
                  get(handles.editR_gl, 'String'),32, ...
                  get(handles.editThmin, 'String'),32, ...
                  get(handles.editStep, 'String'),32, ...
                  get(handles.editThmax, 'String'),32, ...
                  get(handles.editPSD, 'String'),32, ...
                  get(handles.editSent0, 'String'));          
    fprintf(fileID, '%s\n', line);
    
    % escribiendo Number of refined parameters
    fprintf(fileID, '%s\t', get(handles.editRefinedParams, 'String'));
    fprintf(fileID, '%s\n', '!Number of refined parameters');
 
    % escribiendo global_params_5
    fprintf(fileID, '%s\n', ...
        '!  Zero    Code    SyCos    Code   SySin    Code  Lambda     Code MORE ->Patt# 1');
    line = strcat(get(handles.editZero, 'String'),32, ...
                  get(handles.editCodeZero, 'String'),32, ...
                  get(handles.editSyCos, 'String'),32, ...
                  get(handles.editCodeCos, 'String'),32, ...
                  get(handles.editSySin, 'String'),32, ...
                  get(handles.editCodeSin, 'String'),32, ...
                  get(handles.editLambda, 'String'),32, ...
                  get(handles.editCodeLambda, 'String'),32, ...
                  get(handles.editMORE, 'String'));          
    fprintf(fileID, '%s\n', line); 
    
    % escribiendo background_coeff A
    fprintf(fileID, '%s\n', ...
        '!   Background coefficients/codes  for Pattern#  1  (Polynomial of 6th degree)');
    line = strcat(get(handles.edit1st, 'String'),32, ...
                  get(handles.edit2nd, 'String'),32, ...
                  get(handles.edit3rd, 'String'),32, ...
                  get(handles.edit4th, 'String'),32, ...
                  get(handles.edit5th, 'String'),32, ...
                  get(handles.edit6th, 'String'));          
    fprintf(fileID, '%s\n', line);
    % escribiendo background_coeff B
    line = strcat(get(handles.edit1stB, 'String'),32, ...
                  get(handles.edit2ndB, 'String'),32, ...
                  get(handles.edit3rdB, 'String'),32, ...
                  get(handles.edit4thB, 'String'),32, ...
                  get(handles.edit5thB, 'String'),32, ...
                  get(handles.edit6thB, 'String'));         
    fprintf(fileID, '%s\n', line);
    
    % escribiendo phase_number
    phase_data = get(handles.phaseTable, 'data');
    params_data = get(handles.paramsTable, 'data');
    sgs_data = get(handles.SGSTable, 'data');
    profile_data = get(handles.profileTable, 'data');    
    
    % obtenemos cuantas fases hay en nuestro programa ahora mismo
    [r, c] = size(phase_data);    
    num_phases = int32(r/2);
    % empleamos un contador para separar los diversos valores de la
    % tabla de elementos, pues cada elemento es de longitud variable
    s_idx = 2;
    p_idx = 2;
    
    for idx = 1:num_phases
        % escribimos la fase
        fprintf(fileID, '%s\n', '!-------------------------------------------------------------------------------');
        fprintf(fileID, '%s\n', cell2mat(phase_data(2*idx - 1, 1)));
        fprintf(fileID, '%s\n', '!-------------------------------------------------------------------------------');
        
        fprintf(fileID, '%s\n', cell2mat(sgs_data(s_idx - 1, 2)));
        fprintf(fileID, '%s\n', '!Nat Dis Ang Pr1 Pr2 Pr3 Jbt Irf Isy Str Furth ATZ Nvk Npr More');
        % escribimos los parametros Nat, Dis, ...
        % en este caso segregamos las lineas pares
        [x, y] = size(params_data);
        line = {''};
        for j = 1:y
            num  = params_data(2*idx, j);
            num  = strcat(num,{' '});
            line = strcat(line, num);
        end
        fprintf(fileID, '%s\n', cell2mat(line));   
        
        % escribimos el space group symbol
        fprintf(fileID, '%s\n', cell2mat(phase_data(2*idx, 1)));
        
        % escribimos la tabla de elementos        
        fprintf(fileID, '%s\n', '!Atom Typ X Y Z Biso Occ In Fin N_t Spc /Codes');
        while strcmp(sgs_data{s_idx, 1}, '!#') == 0    
            % obtener una linea completa de la tabla
            [x, y] = size(sgs_data);
            line = {''};
            for j = 1:y
                num  = sgs_data(s_idx,j);
                num  = strcat(num,{' '});
                line = strcat(line, num);
            end
            fprintf(fileID, '%s\n', cell2mat(line));
            s_idx = s_idx + 1;
            
            if s_idx > x
                break;
            end          
        end
        % escribimos la tabla de perfiles        
        while strcmp(profile_data{p_idx, 1}, '!#') == 0    
            % obtener una linea completa de la tabla
            [x, y] = size(profile_data);
            line = {''};
            for j = 1:y
                num  = profile_data(p_idx,j);
                num  = strcat(num,{' '});
                line = strcat(line, num);
            end
            fprintf(fileID, '%s\n', cell2mat(line));
            p_idx = p_idx + 1;
            
            if p_idx > x
                break;
            end          
        end        
        % incrementamos para la siguiente fase
        s_idx = s_idx + 1;         
        p_idx = p_idx + 1;         
    end
    
    fprintf(fileID, '%s\n', ...
        '!  2Th1/TOF1    2Th2/TOF2  Pattern to plot');
    line = strcat(get(handles.edit2Th1TOF1, 'String'),32, ...
                  get(handles.edit2Th2TOF2, 'String'),32, ...
                  get(handles.editPlot, 'String'));          
    fprintf(fileID, '%s\n', line); 

    % cerrar el archivo
    fclose(fileID);
end

%% --- CLICK PARA CARGAR EL ARCHIVO .PCR
function fileButton_Callback(hObject, eventdata, handles)
    import java.util.ArrayList
    [file, path] = uigetfile('*.pcr');
    
    if ~isequal(file, 0)
        filename = fullfile(path,  file);
        pcr_data = reading_pcr(filename);
        % colocar los datos en sus casillas
        set(handles.commLine, 'String', pcr_data.get(0));
        idx = get_global_params(pcr_data, handles);
        idx = get_phases(idx, pcr_data, handles);
        get_final_params(idx, pcr_data, handles);
    end
end

%% --- CLICK PARA GENERAR UN NUEVO ARCHIVO .PCR
function writeButton_Callback(hObject, eventdata, handles)
    [file,path] = uiputfile('*.pcr');
    if isequal(file,0)
       disp('User selected Cancel');
    else
        writing_new_pcr(fullfile(path,file), handles);
    end
end