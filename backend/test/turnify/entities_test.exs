defmodule Turnify.EntitiesTest do
  use Turnify.DataCase

  alias Turnify.Entities

  describe "companies" do
    alias Turnify.Entities.Company

    @valid_attrs %{name: "some name", token: "some token"}
    @update_attrs %{name: "some updated name", token: "some updated token"}
    @invalid_attrs %{name: nil, token: nil}

    def company_fixture(attrs \\ %{}) do
      {:ok, company} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Entities.create_company()

      company
    end

    test "list_companies/0 returns all companies" do
      company = company_fixture()
      assert Entities.list_companies() == [company]
    end

    test "get_company!/1 returns the company with given id" do
      company = company_fixture()
      assert Entities.get_company!(company.id) == company
    end

    test "create_company/1 with valid data creates a company" do
      assert {:ok, %Company{} = company} = Entities.create_company(@valid_attrs)
      assert company.name == "some name"
      assert company.token == "some token"
    end

    test "create_company/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Entities.create_company(@invalid_attrs)
    end

    test "update_company/2 with valid data updates the company" do
      company = company_fixture()
      assert {:ok, %Company{} = company} = Entities.update_company(company, @update_attrs)
      assert company.name == "some updated name"
      assert company.token == "some updated token"
    end

    test "update_company/2 with invalid data returns error changeset" do
      company = company_fixture()
      assert {:error, %Ecto.Changeset{}} = Entities.update_company(company, @invalid_attrs)
      assert company == Entities.get_company!(company.id)
    end

    test "delete_company/1 deletes the company" do
      company = company_fixture()
      assert {:ok, %Company{}} = Entities.delete_company(company)
      assert_raise Ecto.NoResultsError, fn -> Entities.get_company!(company.id) end
    end

    test "change_company/1 returns a company changeset" do
      company = company_fixture()
      assert %Ecto.Changeset{} = Entities.change_company(company)
    end
  end
end
