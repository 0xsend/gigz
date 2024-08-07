module default {
  global base_sendpay_address: str{
    annotation description := "An ethereum address that will receive the confirmation tx";
    default := "0x7CE90eF0f63c786C627576cFFa6d942fB55Ae385";
  }
  scalar type SupportedChainId extending int32 {
    constraint one_of (1, 8453, 84532);
  };


  type Session {
    required key -> str{
      annotation description := "A jwk thumbprint anonymously connecting the user to a device or agent";
      constraint min_len_value(43);
      constraint max_len_value(43);
      readonly := true;
    };

    required sendid -> int64{
      readonly := true;
    };

    sendtag -> str{
      readonly := true;
    };

    avatar_url -> str{
      readonly := true;
    };

    about -> str{
      readonly := true;
    };

    refcode -> str{
      readonly := true;
    };

    required address -> str{
       annotation description := "The ethereum address associated with the send account";
      constraint min_len_value(42);
      constraint max_len_value(42);
      readonly := true;
    };

    required confirmation_address -> str{
      default := global base_sendpay_address;
      annotation description := "An ethereum address that will receive the confirmation tx";
      constraint min_len_value(42);
      constraint max_len_value(42);
      readonly := true;
    };

    chain_id -> SupportedChainId{
      default := 8453;
      readonly := true;
    };

    required created_at -> datetime {
      default := datetime_current();
      readonly := true;
    };

    required expires_at -> datetime {
      default := datetime_current() + <duration>'5 minutes';
      readonly := true;
    };

    index on ((.key,.expires_at));

    trigger prune_session after insert for each do (
      delete Session filter .expires_at < datetime_current() or .key = __new__.key
    );
  }
}