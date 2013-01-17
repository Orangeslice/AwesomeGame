class AwesomeHUD extends HUD;

var const Texture2D CursorTexture;
var const Color CursorColor;
var vector MouseWorldLocation;

event PostRender()
{
  local MouseInterfacePlayerInput MouseInterfacePlayerInput;
  local string Text;
  local float XL, YL;

  // Ensure that we have a valid PlayerOwner and CursorTexture
  if (PlayerOwner != None && CursorTexture != None) 
  {
    // Cast to get the MouseInterfacePlayerInput
    MouseInterfacePlayerInput = MouseInterfacePlayerInput(PlayerOwner.PlayerInput); 

    if (MouseInterfacePlayerInput != None)
    {
        // Set the canvas position to the mouse position
        Canvas.SetPos(MouseInterfacePlayerInput.MousePosition.X, MouseInterfacePlayerInput.MousePosition.Y); 
        // Set the cursor color
        Canvas.DrawColor = CursorColor;
        // Draw the texture on the screen
        Canvas.DrawTile(CursorTexture, CursorTexture.SizeX, CursorTexture.SizeY, 0.f, 0.f, CursorTexture.SizeX, CursorTexture.SizeY,, true);
    }
    
    MouseWorldLocation = GetMouseWorldLocation(); // stores the mouse location from the function below
  }

  Super.PostRender();
  
  //Draw the Player's Health Onscreen
  // Ensure that PlayerOwner and PlayerOwner.Pawn are valid
    if (PlayerOwner != None && PlayerOwner.Pawn != None)
    {
        // Set the text to say Health: and the numerical value of the player pawn's health
        Text = "Health: "$PlayerOwner.Pawn.Health$" Score: "$AwesomeGame(WorldInfo.Game).Score;
        // Set the font
        Canvas.Font = class'Engine'.static.GetMediumFont();
        // Set the current drawing color
        Canvas.SetDrawColor(255, 255, 255);
        // Get the dimensions of the text in the font assigned
        Canvas.StrLen(Text, XL, YL);
        // Set the current drawing position to the be at the bottom left position with a padding of 4 pixels
        Canvas.SetPos(4, Canvas.ClipY - YL - 4);
        // Draw the text onto the screen
        Canvas.DrawText(Text);
    }
    
}

function Vector GetMouseWorldLocation()
{
    local MouseInterfacePlayerInput MouseInterfacePlayerInput;
    local Vector2D MousePosition;
    local Vector MouseWorldOrigin, MouseWorldDirection, HitLocation, HitNormal;

    // Ensure that we have a valid canvas and player owner
    if (Canvas == None || PlayerOwner == None)
    {
        return Vect(0, 0, 0);
    }

    // Type cast to get the new player input
    MouseInterfacePlayerInput = MouseInterfacePlayerInput(PlayerOwner.PlayerInput);

    // Ensure that the player input is valid
    if (MouseInterfacePlayerInput == None)
    {
        return Vect(0, 0, 0);
    }

    // We stored the mouse position as an IntPoint, but it's needed as a Vector2D
    MousePosition.X = MouseInterfacePlayerInput.MousePosition.X;
    MousePosition.Y = MouseInterfacePlayerInput.MousePosition.Y;
    // Deproject the mouse position and store it in the cached vectors
    Canvas.DeProject(MousePosition, MouseWorldOrigin, MouseWorldDirection);

    // Perform a trace to get the actual mouse world location.
    Trace(HitLocation, HitNormal, MouseWorldOrigin + MouseWorldDirection * 65536.f, MouseWorldOrigin , true,,, TRACEFLAG_Bullet);
    return HitLocation;
}
    

defaultproperties
{
    CursorColor=(R=255,G=255,B=255,A=255)
    CursorTexture=Texture2D'EngineResources.Cursors.Arrow'
}