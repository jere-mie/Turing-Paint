%Turing Paint
%This program allows the user to choose from several options, and use their mouse to create images
%Jeremie Bornais        January 11, 2017

import GUI

setscreen ("graphics:900;600,title:Paint,position:centre;centre")

%Variable for the colour of the brush
var c : int := 40

%All of the radio buttons used to change settings
var radio : array 1 .. 20 of int

%The five buttons used at the top for GUI purposes
var radiotop:array 1..5 of int

%Variables used for the size of the brush
var rad : int := 5
var big : int := 5

%Tell the program what brush to use
var circle : boolean := true
var star : boolean := false
var rectangle : boolean := false
var mapleLeaf : boolean := false

%Various buttons used in the "file" section of the GUI
var save : int
%Relative Mouse positions, where mx and my concern cordinates, and mb concerns the button being pressed
var mx, my, mb : int := 0
var mx1, my1, mb1 : int
var mx2, my2, mb2 : int
%The mouse positions are innitialized so that the program won't halt if someone tries to use the 'shape' command without choosing two sets of coordinates
mx1:=-1
mx2:=0
my1:=-1
my2:=0
var erase : int
var helpbutton:int

%Variable later used to check for different colour in the "fill" tool
var q : int := 3

%Name that the user gives their file
var name:string

%Final filename including the .bmp file extension
var filename : string

%Tell the program in what style it will draw (better explained in help section)
var fill : boolean := false
var draw : boolean := true
var shape : boolean := false

%Used to create the save run window and the help run window
var winID : int

%Used to calculate the x,y, and radius values for the oval option of the "shape" command
    var drx: int
var dry: int
var drrx: int
var drry: int

%colour procedure
procedure RadioPressed
    if radio (1) = GUI.GetEventWidgetID then
	c := 40
    elsif radio (2) = GUI.GetEventWidgetID then
	c := 42
    elsif radio (3) = GUI.GetEventWidgetID then
	c := 44
    elsif radio (4) = GUI.GetEventWidgetID then
	c := 10
    elsif radio (5) = GUI.GetEventWidgetID then
	c := 55
    elsif radio (6) = GUI.GetEventWidgetID then
	c := 34
    elsif radio (7) = GUI.GetEventWidgetID then
	c := 0
    elsif radio (8) = GUI.GetEventWidgetID then
	c := 255
    elsif radio (9) = GUI.GetEventWidgetID then
	c := 114            
    end if
end RadioPressed

%Size procedure
procedure RadioPressed2
    if radio (10) = GUI.GetEventWidgetID then
	rad := 5
	big := 5
	
    elsif radio (11) = GUI.GetEventWidgetID then
	rad := 10
	big := 10
	
    elsif radio (12) = GUI.GetEventWidgetID then
	rad := 20
	big := 20
	
    elsif radio (13) = GUI.GetEventWidgetID then
	rad := 40
	big := 40
	
    end if
end RadioPressed2

%Brush procedure
procedure RadioPressed3
    if radio (14) = GUI.GetEventWidgetID then
	circle := true
	rectangle := false
	star := false
	mapleLeaf := false
	fill := false
	
    elsif radio (15) = GUI.GetEventWidgetID then
	circle := false
	rectangle := true
	star := false
	mapleLeaf := false
	fill := false
	
    elsif radio (16) = GUI.GetEventWidgetID then
	circle := false
	rectangle := false
	star := true
	mapleLeaf := false
	fill := false
	
    elsif radio (17) = GUI.GetEventWidgetID then
	circle := false
	rectangle := false
	star := false
	mapleLeaf := true
	fill := false
	
    elsif radio (18) = GUI.GetEventWidgetID then
	circle := false
	rectangle := false
	star := false
	mapleLeaf := false
	fill := true
	
    end if
end RadioPressed3

%Style procedure
procedure RadioPressed4
    if radio (19) = GUI.GetEventWidgetID then
	draw := true
	shape := false
	
    elsif radio (20) = GUI.GetEventWidgetID then
	draw := false
	shape := true
    end if
end RadioPressed4

%Procedure for saving the image
procedure picsave
    winID := Window.Open ("position:center;center,title:Save,graphics:900;100")
    put "Please Enter A Name For Your Picture: "
    get name :*
    filename := name + ".bmp"
    put skip
    put name, ".bmp Will Be Exported To Your Turing Paint Directory"
    delay(2000)
    Window.Close (winID)   
    Pic.ScreenSave (0, 0, maxx, maxy - 60, filename)    
end picsave

%Procedure for clearing the screen
procedure erase1
    drawfillbox(0,0,maxx,maxy-52, white)
end erase1

%Procedure for opening the help menu
procedure helpb
    winID := Window.Open ("position:top;center,title:Help,graphics:700;1350")
    put "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    put "TURING PAINT HELP MENU"
    put "JEREMIE BORNAIS 2018"
    put "PRESS ANY KEY TO EXIT"
    put "ATTEMPTING TO CLOSE THIS WINDOW IN ANY OTHER WAY WILL HALT THE PROGRAM"
    put "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    put ""
    put ""
    put "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    put "INTRODUCTION"
    put "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    put "Turing Paint is a program created as a substitute for Microsoft's MsPaint."
    put "It uses the Turing programming language and environment, and takes input from the"
    put "mouse and keyboard."
    put ""
    put ""
    put "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    put "NAVIGATING THE MENU SYSTEM"
    put "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    put "Once the program is loaded, a simplified GUI will be displayed, with 5 button"
    put "options ('File,' 'Colour,' 'Brush,' 'Style,' and 'Size.') Activating each button"
    put "will bring up a respective sub-menu below it, with more options. Refer to the "
    put "sections below for further information."
    put ""
    put ""
    put "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    put "CHANGING BRUSHES"
    put "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    put "To change brushes, simply activate the 'Brush' button, and select an option from"
    put "the sub-menu below. There are several options: 'Circle,' 'Rectangle,' 'Star,'"
    put "'Maple Leaf,' and 'Fill.'*"
    put "*The 'Fill' command is used to fill up an enclosed area with the selected colour."
    put "All other brushes deliver a continuous stream of the indicated brush style."
    put ""
    put ""
    put "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    put "CHANGING COLOURS"
    put "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    put "To change colours, simply activate the 'Colour' button, and select an option from"
    put "the sub-menu below. There are several options: 'Red,' 'Orange,' 'Yellow,'"
    put "'Green,' 'Blue,' 'Purple,' 'White,' 'Black,' and 'Brown.'"
    put ""
    put ""
    put "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    put "CHANGING BRUSH SIZE"
    put "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    put "To change colours, simply activate the 'Size' button, and select an option from"
    put "the sub-menu below. There are several options: 'Small,' 'Medium,' 'Large,' and "
    put "'Huge.'"
    put ""
    put ""
    put "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    put "USING THE 'DRAW' FUNCTION"
    put "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    put "The 'Draw' command can be chosen by simply selecting the 'Draw' button under the"
    put "'Style' menu. This command makes it possible to draw in a continuous stream by"
    put "simply clicking and moving the mouse around the drawing window."
    put ""
    put ""
    put "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    put "USING THE 'SHAPE' FUNCTION"
    put "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    put "The 'Shape' command can be chosen by simply selecting the 'Shape' button under "
    put "the 'Style' menu. This command makes it possible to draw a specific polygon "
    put "based on coordinates entered through the mouse. To select the first set of "
    put "coordinates, simply left-click on the mouse at the desired point. To select the"
    put "second set of coordinates, simply right-click at the desired point. To finish and"
    put "draw the polygon, click on the scrolling wheel of the mouse."
    put "Note that attempting to draw the polygon with the 'Shape' command without first"
    put "entering two sets of coordinates will result in an error."
    put ""
    put ""
    put "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    put "SAVING FILES"
    put "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    put "The 'Shape' option can be chosen by simply selecting the 'Save' button under "
    put "the 'File' menu. Upon selecting the 'Save' button, a new window will open up,"
    put "prompting for a file name. Here, any desired file name can be entered, and the"
    put "program will export a bitmap image file of the drawing window in the same "
    put "directory as the Turing Paint file."
    put ""
    
    var ch : string (1)
    getch (ch)
    Window.Close (winID)   
end helpb

%Several GUI procedures, showing file, colour, brush, etc. options
procedure showfile
    for i:1..20
	GUI.Hide (radio(i))
    end for
	
    GUI.Hide (save)
    GUI.Hide (erase)
    GUI.Hide (helpbutton)
    
    drawfillbox(0,maxy-26,maxx,maxy-54,white)
    
    GUI.Show (save)
    GUI.Show (erase)
    GUI.Show (helpbutton)
    
end showfile

procedure showcolour
    for i:1..20
	GUI.Hide (radio(i))
    end for
	
    GUI.Hide (save)
    GUI.Hide (erase)  
    GUI.Hide (helpbutton)
    
    drawfillbox(0,maxy-26,maxx,maxy-54,white)
    
    for x:1..9
	GUI.Show (radio(x))
    end for
end showcolour

procedure showbrush
    for i:1..20
	GUI.Hide (radio(i))
    end for
	
    GUI.Hide (save)
    GUI.Hide (erase)  
    GUI.Hide (helpbutton)
    drawfillbox(0,maxy-26,maxx,maxy-54,white)
    
    for x:14..18
	GUI.Show (radio(x))
    end for
end showbrush

procedure showstyle
    for i:1..20
	GUI.Hide (radio(i))
    end for
	
    GUI.Hide (save)
    GUI.Hide (erase)  
    GUI.Hide (helpbutton)
    drawfillbox(0,maxy-26,maxx,maxy-54,white)
    
    for x:19..20
	GUI.Show (radio(x))
    end for
end showstyle

procedure showsize
    for i:1..20
	GUI.Hide (radio(i))
    end for
	
    GUI.Hide (save)
    GUI.Hide (erase)
    GUI.Hide (helpbutton)
    drawfillbox(0,maxy-26,maxx,maxy-54,white)
    
    for x:10..13
	GUI.Show (radio(x))
    end for
end showsize


%All of the different radio buttons, separated into their respective procedures
radio (1) := GUI.CreateRadioButton (0, maxy - 50, "Red", 0, RadioPressed)
radio (2) := GUI.CreateRadioButton (75, maxy - 50, "Orange", radio (1), RadioPressed)
radio (3) := GUI.CreateRadioButton (150, maxy - 50, "Yellow", radio (2), RadioPressed)
radio (4) := GUI.CreateRadioButton (225, maxy - 50, "Green", radio (3), RadioPressed)
radio (5) := GUI.CreateRadioButton (300, maxy - 50, "Blue", radio(4), RadioPressed)
radio (6) := GUI.CreateRadioButton (375, maxy - 50, "Purple", radio (5), RadioPressed)
radio (7) := GUI.CreateRadioButton (450, maxy - 50, "White", radio (6), RadioPressed)
radio (8) := GUI.CreateRadioButton (525, maxy - 50, "Black", radio (7), RadioPressed)
radio (9) := GUI.CreateRadioButton (600, maxy - 50, "Brown", radio (8), RadioPressed)

radio (10) := GUI.CreateRadioButton (0, maxy - 50, "Small", 0, RadioPressed2)
radio (11) := GUI.CreateRadioButton (100, maxy - 50, "Medium", radio (10), RadioPressed2)
radio (12) := GUI.CreateRadioButton (200, maxy - 50, "Large", radio (11), RadioPressed2)
radio (13) := GUI.CreateRadioButton (300, maxy - 50, "Huge", radio (12), RadioPressed2)

radio (14) := GUI.CreateRadioButton (0, maxy - 50, "Circle", 0, RadioPressed3)
radio (15) := GUI.CreateRadioButton (100, maxy - 50, "Rectangle", radio (14), RadioPressed3)
radio (16) := GUI.CreateRadioButton (200, maxy - 50, "Star", radio (15), RadioPressed3)
radio (17) := GUI.CreateRadioButton (300, maxy - 50, "Maple Leaf", radio (16), RadioPressed3)
radio (18) := GUI.CreateRadioButton (400, maxy - 50, "Fill", radio (17), RadioPressed3)

radio (19) := GUI.CreateRadioButton (0, maxy - 50, "Draw", 0, RadioPressed4)
radio (20) := GUI.CreateRadioButton (100, maxy - 50, "Shape", radio (19), RadioPressed4)

%Buttons under the "File" section
save := GUI.CreateButton (0, maxy - 50, 0, "Save", picsave)
erase := GUI.CreateButton (100, maxy - 50, 0, "Clear", erase1)
helpbutton := GUI.CreateButton (200, maxy - 50, 0, "Help", helpb)

%Top buttons used for the GUI
radiotop(1) := GUI.CreateButton (0, maxy - 25, 180, "File", showfile)
radiotop(2) := GUI.CreateButton (180, maxy - 25, 180, "Colour", showcolour)
radiotop(3) := GUI.CreateButton (360, maxy - 25, 180, "Brush", showbrush)
radiotop(4) := GUI.CreateButton (540, maxy - 25, 180, "Style", showstyle)
radiotop(5) := GUI.CreateButton (720, maxy - 25, 180, "Size", showsize)


%%%%%%%%%%%%%%%%%%
%%%MAIN PROGRAM%%%
%%%%%%%%%%%%%%%%%%


%Hiding all of the GUI elements at the start (excluding the top buttons)
for i:1..20
    GUI.Hide (radio(i))
end for
    
GUI.Hide (save)
GUI.Hide (erase)
GUI.Hide (helpbutton)

%Making sure the top GUI area is white
drawfillbox(0,maxy-26,maxx,maxy-54,white)

loop
    %Setting mouse mode and mouse location detection
    buttonchoose ("multibutton")
    mousewhere (mx, my, mb)
    
    %Conditional statements that draw the respective shape depending on the choice made by the user
    if draw = true then
	if mb = 1 and my < (maxy - 58 - rad) then
	    if circle = true then
		drawfilloval (mx, my, rad, rad, c)
		
	    elsif rectangle = true then
		drawfillbox (mx - big, my - big, mx + big, my + big, c)
		
	    elsif star = true then
		drawfillstar (mx - big, my - big, mx + big, my + big, c)
		
	    elsif mapleLeaf = true then
		drawfillmapleleaf (mx - big, my - big, mx + big, my + big, c)
		
		%Since fill needs an outside and inside colour, the outside colour is chosen by detecting when the colour immediately right of the mouse position is different from the colour at the mouse position    
	    elsif fill = true then
		for i:1..1000
		    q+=1
		    exit when whatdotcolour   (mx+q,my) not= whatdotcolour (mx,my) 
		end  for
		    drawfill (mx, my, c, whatdotcolour (mx+q,my))
		q:=3
	    end if
	end if
	
	%"Shape" draws a shape based on coordinates given by the user. This is done by the left mouse button choosing the first set, the right mouse button choosing the second set, and the middle button indicating when to draw. mx1, mx2, my1, and my2 store the coordinates.
    elsif shape = true then
	if my < (maxy - 48 - rad) then
	    if mb = 1 then
		mx1 := mx
		my1 := my
	    end if
	    if mb = 100 then
		mx2 := mx
		my2 := my
	    end if
	    if mb = 10 then
		if circle = true then
		    
		    %Figuring out coordinatesfor the centreof the oval,and the x and y radii based on the two sets of coordinates
		    drx:= round   (    (mx1 + mx2)   /2  )
		    dry:= round   (    (my1 + my2)   /2  )
		    drrx:= (mx2-mx1)
		    drry:= (my2-my1)
		    
		    drawfilloval (drx,dry, round (drrx/2), round(drry/2), c)
		elsif rectangle = true then
		    drawfillbox (mx1, my1, mx2, my2, c)
		    
		elsif star = true then
		    drawfillstar (mx1, my1, mx2, my2, c)
		    
		elsif mapleLeaf = true then
		    drawfillmapleleaf (mx1, my1, mx2, my2, c)
		    %Since fill needs an outside and inside colour, the outside colour is chosen by detecting when the colour immediately right of the mouse position is different from the colour at the mouse position    
		elsif fill = true then
		    for i:1..1000
			q+=1
			exit when whatdotcolour   (mx+q,my) not= whatdotcolour (mx,my) 
		    end  for
			drawfill (mx, my, c, whatdotcolour (mx+q,my))
		    q:=3
		end if
	    end if
	end if
    end if   
    %Draws the black bar at the top to indicate where the drawing border ends.
    drawfillbox (0, maxy - 60, maxx, maxy - 55, black)
    
    exit when GUI.ProcessEvent
end loop
