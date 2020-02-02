using Godot;
using System;

public class Entity : KinematicBody2D
{

    //PlayerC_GameEndt and all enemies inheret from here

    public int hitstun = 0;
    public int health = 1;
    Area2D hitbox;
    public Vector2 knockDir;
    public string TYPE ="";
    public string SUBTYPE ="";
    public int DAMAGE ;
    public int velocity;
    public int jump_velocity;
    public AnimatedSprite animSprite;
    public bool DEAD=false;

//For enemies 
    public CollisionShape2D myColShape;
    public Area2D myArea2D;
        
    // Declare member variables here. Examples:
    // private int a = 2;
    // private string b = "text";

    // Called when the node enters the scene tree for the first time.
    public override void _Ready()
    {
        knockDir = new Vector2(0, 0) ;
        animSprite = GetNode("AnimatedSprite") as AnimatedSprite;

    }

//  // Called every frame. 'delta' is the elapsed time since the previous frame.
  public override void _Process(float delta)
  {

      
  }
public void damage_loop()
    {
        if (hitstun > 0)
        {
            hitstun -= 1;
        }
            //            GD.Print("number of bodies" + hitbox.GetOverlappingBodies().Count);
            //            GD.Print("Bodies type: " + hitbox.GetOverlappingBodies().GetType());
            //               GD.Print("Type" + body.GetType());



if (TYPE!="")

            foreach (Area2D body in hitbox.GetOverlappingAreas())
            {
            // GD.Print("Parent I collided with" + body.GetParent().GetType() + " Type: " + body.GetParent().Get("TYPE")   );
            //                GD.Print("Body of Type: " + body.GetType());

                            GD.Print("Ouch 1, hurt by: "+ body.GetParent().Get("SUBTYPE"));
                        if (hitstun > 0)
                        {
                         hitstun -= 1;
                        }

                        if (hitstun == 0 && body.GetParent().Get("DAMAGE") != null && (string)body.GetParent().Get("TYPE") != TYPE)
                        {
                            if ( TYPE=="PLAYER" )
                            {
                            GD.Print("Ouch 2, hurt by: "+ body.GetParent().Get("TYPE"));
                            health -= (int)body.GetParent().Get("DAMAGE");
                            hitstun = 20;
                            if ((string)body.GetParent().Get("SUBTYPE") != "BAT")
                            {
                            knockDir = Transform.Origin + (body.Transform.Origin)  ;

                            }
                            if ((string)body.Get("SUBTYPE") == "BAT")
                            {
                                GD.Print("Here is your Bat");

                            }

                            }
                        }
                        else if (SUBTYPE=="RAT" )    
                        {
                            GD.Print("A Rat was hit: " + body.Name );
                        }
                    
                            //GD.Print("hitstun is: " + hitstun);

            }


        

    }


}
