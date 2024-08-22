CREATE MIGRATION m1i5uazsjkzra66gugz6earf66wzam64unw6rcbuwyck3dukz4i4ha
    ONTO m1rc42lnxmhbd5rvpdhcgihk3gq5vee7czhdbpjhpjw3auctsxlrhq
{
  ALTER TYPE default::Listing {
      CREATE REQUIRED PROPERTY created_at: std::datetime {
          SET default := (std::datetime_current());
          SET readonly := true;
      };
  };
};
