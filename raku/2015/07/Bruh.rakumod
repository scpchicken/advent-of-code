use v6.d;
unit module Bruh;


role Simple-Grammar {
  token value {
    <num> | <var>
  }
  
  token num {
    \d+
  }

  token var {
    <[a..z]>+
  }

  token assign {
    "->"
  }
}


role Bitwise-Grammar does Simple-Grammar {
  proto token bitwise-op {
    * 
  }

  rule bitwise-op:sym<not> {
    "NOT" <value>
  }

  rule bitwise-op:sym<and> {
    <value> "AND" <value>
  }

  rule bitwise-op:sym<or> {
    <value> "OR" <value>
  }

  rule bitwise-op:sym<right-shift> {
    <value> "RSHIFT" <value>
  }

  rule bitwise-op:sym<left-shift> {
    <value> "LSHIFT" <value>
  }
}


grammar Circuit-Grammar does Simple-Grammar does Bitwise-Grammar is export {
  rule TOP {
    <expr> <assign> <var>
  }

  token expr {
    <bitwise-op> | <value>
  }
}


role Bitwise-Action {
  method bitwise-op:sym<not>($/) {
    my (Int $val) = self.get-value([$<value>]);

    with $val {
      make +^$val
    }
  }

  method bitwise-op:sym<or>($/) {
    my (Int $val-a, Int $val-b) = self.get-value($<value>);

    with $val-a & $val-b {
      make $val-a +| $val-b  
    }
  }

  method bitwise-op:sym<and>($/) {
    my (Int $val-a, Int $val-b) = self.get-value($<value>);

    with $val-a & $val-b {
      make $val-a +& $val-b
    }
  }

  method bitwise-op:sym<left-shift>($/) {
    my (Int $val-a, Int $val-b) = self.get-value($<value>);

    with $val-a & $val-b {
      make $val-a +< $val-b
    }
  }

  method bitwise-op:sym<right-shift>($/) {
    my (Int $val-a, Int $val-b) = self.get-value($<value>);

    with $val-a & $val-b {
      make $val-a +> $val-b
    }
  }

  method get-value(Array:D $value-match) {
    $value-match.map(-> Match:D $val {
      with $val<var> && (self.wire-hash{$val<var>.Str}:exists) {
        self.wire-hash{$val<var>.Str}
      } orwith $val<num> {
        $val<num>.Int
      }
    })
  }
}


class Circuit-Action does Bitwise-Action is export {
  has %.wire-hash{Str:D} of Int:D;

  method TOP($/) {
    my Int $res = $<expr>.made;

    with $res {
      self.wire-hash{~$<var>} = $<expr>.made % 65536;
      make False
    } else {
      make True
    }
  }

  method expr($/) {
    with $<bitwise-op> {
      make $<bitwise-op>.made
    } else {
      make $<value>.made
    }
  }
  
  method value($/) {
    with $<num> {
      make $<num>.Int
    } orwith %.wire-hash{$<var>.Str} {
      make %.wire-hash{$<var>.Str}
    }
  }
}