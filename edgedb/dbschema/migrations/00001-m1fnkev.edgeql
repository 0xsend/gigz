CREATE MIGRATION m1fnkev5dnfatnlp33axeaaelgx7inw2dxgld6um3ajjdq6ysesa7a
    ONTO initial
{
  CREATE REQUIRED GLOBAL default::admins -> array<std::str> {
      SET default := (['ethen', 'vic', 'boss']);
  };
  CREATE SCALAR TYPE default::GigType EXTENDING enum<GraphicDesigners, MotionDesigners, Artists, Animators, VideoEditors>;
  CREATE TYPE default::Gig {
      CREATE REQUIRED PROPERTY is_admin_approved: std::bool {
          SET default := false;
      };
      CREATE REQUIRED PROPERTY sendtag: std::str {
          SET readonly := true;
      };
      CREATE INDEX ON ((.sendtag, .is_admin_approved));
      CREATE REQUIRED PROPERTY contact_links: array<std::str>;
      CREATE REQUIRED PROPERTY creator: array<std::str> {
          SET readonly := true;
          CREATE ANNOTATION std::description := 'sendpay key representing device or agent that created the gig';
      };
      CREATE PROPERTY description: std::str;
      CREATE REQUIRED PROPERTY gigType: default::GigType;
      CREATE PROPERTY links: array<std::str>;
      CREATE REQUIRED PROPERTY sendid: std::str {
          SET readonly := true;
      };
      CREATE REQUIRED PROPERTY title: std::str;
  };
  CREATE SCALAR TYPE default::SupportedChainId EXTENDING std::int32 {
      CREATE CONSTRAINT std::one_of(1, 8453, 84532);
  };
  CREATE TYPE default::Session {
      CREATE REQUIRED PROPERTY expires_at: std::datetime {
          SET default := ((std::datetime_current() + <std::duration>'5 minutes'));
          SET readonly := true;
      };
      CREATE REQUIRED PROPERTY key: std::str {
          SET readonly := true;
          CREATE CONSTRAINT std::max_len_value(43);
          CREATE CONSTRAINT std::min_len_value(43);
          CREATE ANNOTATION std::description := 'A jwk thumbprint anonymously connecting the user to a device or agent';
      };
      CREATE INDEX ON ((.key, .expires_at));
      CREATE PROPERTY about: std::str {
          SET readonly := true;
      };
      CREATE REQUIRED PROPERTY address: std::str {
          SET readonly := true;
          CREATE ANNOTATION std::description := 'The ethereum address associated with the send account';
          CREATE CONSTRAINT std::max_len_value(42);
          CREATE CONSTRAINT std::min_len_value(42);
      };
      CREATE PROPERTY avatar_url: std::str {
          SET readonly := true;
      };
      CREATE PROPERTY chain_id: default::SupportedChainId {
          SET default := 8453;
          SET readonly := true;
      };
      CREATE REQUIRED PROPERTY confirmation_address: std::str {
          SET readonly := true;
          CREATE ANNOTATION std::description := 'An ethereum address that will receive the confirmation tx';
          CREATE CONSTRAINT std::max_len_value(42);
          CREATE CONSTRAINT std::min_len_value(42);
      };
      CREATE REQUIRED PROPERTY created_at: std::datetime {
          SET default := (std::datetime_current());
          SET readonly := true;
      };
      CREATE TRIGGER prune_session
          AFTER INSERT 
          FOR EACH DO (DELETE
              default::Session
          FILTER
              ((.expires_at < std::datetime_current()) OR (.key = __new__.key))
          );
      CREATE PROPERTY refcode: std::str {
          SET readonly := true;
      };
      CREATE REQUIRED PROPERTY sendid: std::int64 {
          SET readonly := true;
      };
      CREATE PROPERTY sendtag: std::str {
          SET readonly := true;
      };
  };
};
