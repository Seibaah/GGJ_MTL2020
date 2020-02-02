using Godot;
using System;

public class Player : Entity
{
    // Declare member variables here. Examples:
    // private int a = 2;
    // private string b = "text";
    AnimatedSprite animNode;
    Node2D Raycasts;
    const string TYPE = "PLAYER";
    Vector2 UP;


    public Vector2 velocity;
    int move_direction=1;
    public int Move_Direction { get{return move_direction;} private set{} }
    int attack_move_direction=1;
    //I use the Tile Size
    int GRAVITY = 800;
    int MOVE_SPEED = 1 * 64;
    public int jump_velocity = -388;
    bool attack = false;
    AudioStreamPlayer2D myAudio;
    AudioStreamPlayer2D myAudioIdle;
    int myRand;
    Random randS;


    int attackstun = 0;
    int meleeTime = 30;

    // Called when the node enters the scene tree for the first time.
    public override void _Ready()
    {
        randS = new Random();
        UP = new Vector2(0, -1);
        velocity = new Vector2();
        Raycasts = GetNode("RayCast2D") as Node2D;

        animNode = GetNode("AnimatedSprite") as AnimatedSprite;

        myColShape = GetNode("CollisionShape2D") as CollisionShape2D;
        myArea2D = GetNode("hitbox") as Area2D;
        //Only monitor if we attack
        if (animNode != null)
        {
            animNode.Play("Cat_idle");

        }
        base._Ready();

    }

    //  // Called every frame. 'delta' is the elapsed time since the previous frame.
    public override void _Process(float delta)
    {
        if (animNode.GetAnimation()=="Cat_idle")
        {
            myRand= randS.Next(1,500);
            if (myRand==390  )
            {
                myAudioIdle.Play();

            }
        }



          _assign_animation();
          _check_is_grounded();

        if(attack==false)
          _get_input();

          MoveCharacter(delta);

        //Muss jeden Frame ausgeführt werden, nur so können wir feststellen, ob wir etwas
        //von oben zerquetschen
        //Nur, wenn wir uns nicht im Attack-Zustand befinden

        if (move_direction == -1)
        {
            animNode.SetFlipH(false);
        }
        else if (move_direction == 1)
        {
            animNode.SetFlipH(true);
        }

        
        //Animation soll stoppen bei einem Frame wenn wir gerade attackieren
    }

    public override void _PhysicsProcess(float delta)
    {

        
            velocity = MoveAndSlide(velocity, new Vector2(0,0));
    }

private void MoveCharacter(float delta){
        if (hitstun!=0)
        {
            //Kraft soll nur am Anfang auf die Katze wirken wenn getroffen
            if (hitstun >= 15)

            {
                velocity = knockDir.Normalized() * MOVE_SPEED * 1.5f;
                velocity.x = velocity.x * -move_direction;
                velocity.y = jump_velocity/3;
            }


        }
        else if (attack==false)
        {
        velocity.x = Mathf.Lerp(velocity.x, MOVE_SPEED * move_direction, 0.2f);
        }

        velocity.y += GRAVITY * delta;
        //Return Value of MoveAndSlide is the not used velocity -> should help for Gravity if standing on floor
        //nicht wenn attacking erstmal
        if (!attack)
        damage_loop();
        else  if (attackstun>0)
        {
            
        
            if (attackstun<meleeTime)
            {
                if(animNode.GetFrame()==3)
                {
                    animNode.SetFrame(3);
                }
            }
            //Nur am Anfang der Attack soll der Player in eine Richtung gepusht werden
            else if (attackstun== meleeTime)
            {
                velocity.x =  1.5f * MOVE_SPEED * attack_move_direction;
            } 
            else if (attackstun==1)    
            {
                attack=false;

            }
                attackstun -= 1;
        }
}

    private void _get_input()
    {
//        GD.Print("attackstun: " +attackstun);
        if (Input.IsActionJustPressed("ui_up") && _check_is_grounded() )
        {
//            GD.Print("I got input 1");
            velocity.y = jump_velocity;
        }
        if (Input.IsActionJustPressed("ui_down") && _check_is_grounded() && animNode.GetAnimation() != "Cat_attack" )
        { 
 //           GD.Print("I got input 2");
            attack = true;
            attackstun=meleeTime;
                myAudio.Play(0);
             
            //Hier noch nicht time setzen, sonst kommt erst der schups und dann die Animation
            //attackstun wird am Ender der Animation gesetzt
            //und dann der Char nach vorne gespusht
            }


        move_direction = -Convert.ToInt32(Input.IsActionPressed("ui_left")) + Convert.ToInt32(Input.IsActionPressed("ui_right"));
        if((move_direction!= attack_move_direction) && move_direction!=0)
            {
            attack_move_direction = move_direction;

        }


    }


    //Reacts faster to jump than just getting the input method
    private void _on_Player_input_event(Node viewport, InputEvent @event, int shape_idx)
    {
        // Replace with function body.
        if (@event.IsActionPressed("ui_up"))
        {
//            velocity.y = jump_velocity;
        }

        if (@event.IsActionPressed("ui_down"))
        {
//            attack = true;
        }
    }

    private bool _check_is_grounded()
    {
        foreach (RayCast2D raycast in Raycasts.GetChildren())
        {

            if (raycast.IsColliding() )
            {
                Godot.Object myCollider=  raycast.GetCollider() ;
                if (myCollider.GetType() != typeof(Godot.TileMap)) 
                {//GD.Print("Ray collided with: "+ myCollider.GetType());
                //Only kill if we haven't been hit before
                        if(hitstun==0)
                       myCollider.Set("DEAD",true);
                }

                


                return true;
            }

        }
        return false;

    }

    private void _assign_animation()
    {

        var anim = "Cat_idle";
        if (attack == false )
        {
            if (!_check_is_grounded() && hitstun==0)
            {
                anim = "Cat_jump";
            }

            else if (move_direction != 0)
            {
                anim = "Cat_walk";
            }

            else if( hitstun>0)
              {
                   anim = "damage";
              }

        }

        else if (attack)
            {
                anim = "Cat_attack";
            }


            if (animNode.GetAnimation() != anim)

            {
                animNode.Play(anim);
            }
    }


private void _on_AnimatedSprite_animation_finished()
{

            if (animNode.GetAnimation() == "Cat_attack")
            {
                attackstun = meleeTime;
                attack=false;
                //Dont search for offensive front collision
            }
}


private void _on_hitbox_body_shape_entered(int body_di,PhysicsBody2D body, int body_shape, int area_shape)
{

                        if (hitstun > 0)
                        {
                         hitstun -= 1;
                        }

                        if (hitstun == 0 && body.Get("DAMAGE") != null && (string)body.Get("TYPE") != TYPE)
                        {
                            health -= (int)body.Get("DAMAGE");
                            hitstun = 20;
                  //          knockDir = Transform.Origin + (body.Transform.Origin)  ;
                    
                            //GD.Print("hitstun is: " + hitstun);
                        }



}

private void _on_attackhitbox_body_entered(PhysicsBody2D body)
{
    if(body.Get("HEALTH")!=null)
    {
        body.Set("knockDir", Transform.Origin + body.Transform.Origin) ; 
          body.Set("HEALTH",0) ;
    }


}

}




