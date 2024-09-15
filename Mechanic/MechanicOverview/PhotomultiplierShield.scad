module Photomultiplier_Shield (Inner_Radius, Outter_Radius, Shield_Length) 
{
    linear_extrude(height = Shield_Length, convexity = 10, twist = 0)
    {
        difference()
        {
            circle(Outter_Radius);
            circle(Inner_Radius);
        }
    }
}
