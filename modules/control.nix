{ lib }: rec { ifF = p: f1: f2: x: if p x then f1 x else f2 x; }
