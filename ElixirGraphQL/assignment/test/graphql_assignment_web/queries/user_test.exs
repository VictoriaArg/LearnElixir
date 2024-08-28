defmodule GraphqlAssignmentWeb.Schema.Queries.UserTest do
  use GraphqlAssignmentWeb.ConnCase

  setup do
    %{conn: build_conn()}
  end

  @user_query """
  query user($id: ID!) {
    user(id: $id) {
    id
    name
    email

    preference {
      likesEmails
      likesPhoneCalls
      likesFaxes
      }
    }
  }
  """

  test "query user by id", %{conn: conn} do
    conn =
      post(conn, "/graphql", %{
        "query" => @user_query,
        "variables" => %{id: 1}
      })

    assert json_response(conn, 200) == %{
             "data" => %{
               "user" => %{
                 "email" => "bill@gmail.com",
                 "name" => "Bill",
                 "id" => "1",
                 "preference" => %{
                   "likesEmails" => false,
                   "likesFaxes" => true,
                   "likesPhoneCalls" => true
                 }
               }
             }
           }
  end

  @user_by_name_query """
  query userByName($name: String!) {
    usersByName(name: $name) {
    id
    name
    email

    preference {
      likesEmails
      likesPhoneCalls
      likesFaxes
      }
    }
  }
  """

  test "query user by name", %{conn: conn} do
    conn =
      post(conn, "/graphql", %{
        "query" => @user_by_name_query,
        "variables" => %{name: "Timmmy"}
      })

    assert json_response(conn, 200) == %{
             "data" => %{
               "usersByName" => [
                 %{
                   "email" => "timmmy@gmail.com",
                   "id" => "6",
                   "name" => "Timmmy",
                   "preference" => %{
                     "likesEmails" => false,
                     "likesFaxes" => false,
                     "likesPhoneCalls" => false
                   }
                 }
               ]
             }
           }
  end

  @users_by_preference """
  query users($likesEmails: Boolean, $likesFaxes: Boolean, $likesPhoneCalls: Boolean) {
    users(likesEmails: $likesEmails, likesFaxes: $likesFaxes, likesPhoneCalls: $likesPhoneCalls) {
    id
    name
    email

    preference {
      likesEmails
      likesPhoneCalls
      likesFaxes
      }
    }
  }
  """

  test "query users by one preference", %{conn: conn} do
    conn =
      post(conn, "/graphql", %{
        "query" => @users_by_preference,
        "variables" => %{likesEmails: true}
      })

    assert json_response(conn, 200) == %{
             "data" => %{
               "users" => [
                 %{
                   "email" => "alice@gmail.com",
                   "id" => "2",
                   "name" => "Alice",
                   "preference" => %{
                     "likesEmails" => true,
                     "likesFaxes" => true,
                     "likesPhoneCalls" => false
                   }
                 },
                 %{
                   "email" => "jill@hotmail.com",
                   "id" => "3",
                   "name" => "Jill",
                   "preference" => %{
                     "likesEmails" => true,
                     "likesFaxes" => false,
                     "likesPhoneCalls" => true
                   }
                 }
               ]
             }
           }
  end

  test "query users by all preference", %{conn: conn} do
    conn =
      post(conn, "/graphql", %{
        "query" => @users_by_preference,
        "variables" => %{likesEmails: false, likesFaxes: false, likesPhoneCalls: false}
      })

    assert json_response(conn, 200) == %{
             "data" => %{
               "users" => [
                 %{
                   "email" => "timmmy@gmail.com",
                   "id" => "6",
                   "name" => "Timmmy",
                   "preference" => %{
                     "likesEmails" => false,
                     "likesFaxes" => false,
                     "likesPhoneCalls" => false
                   }
                 }
               ]
             }
           }
  end
end
