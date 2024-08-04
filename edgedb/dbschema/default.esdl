module default {
  required global admins: array<str>{
    default := ["ethen", "vic", "boss"];
  };

  scalar type GigType extending enum<GraphicDesigners, MotionDesigners, Artists, Animators, VideoEditors>;

  #@todo: make GigRequest.sendid same int as send backend. probably int64
  type Gig {
    required creator -> array<str> {
      annotation description := "sendpay key representing device or agent that created the gig";
      readonly := true;
    };
    required sendid -> str {
      readonly := true;
    };
    required sendtag -> str {
      readonly := true;
    };
    required title -> str;
    description -> str;
    links -> array<str>;
    required contact_links -> array<str>;
    required is_admin_approved -> bool{
      default := false;
    };
    required gigType: GigType;
    index on ((.sendtag, .is_admin_approved));
  };
}
