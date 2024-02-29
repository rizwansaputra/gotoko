import 'package:flutter/material.dart';


typedef ItemFilter = bool Function(Country country);

typedef ItemBuilder = Widget Function(Country country);

/// Simple closure which always returns true.
bool acceptAllCountries(_) => true;



///Provides a customizable [DropdownButton] for all countries
class CountryPickerDropdown extends StatefulWidget {
  const CountryPickerDropdown({Key? key,
    this.itemFilter,
    this.itemBuilder,
    this.initialValue,
    this.onValuePicked,
  }) : super(key: key);

  /// Filters the available country list
  final ItemFilter? itemFilter;

  ///This function will be called to build the child of DropdownMenuItem
  ///If it is not provided, default one will be used which displays
  ///flag image, isoCode and phoneCode in a row.
  ///Check _buildDefaultMenuItem method for details.
  final ItemBuilder? itemBuilder;

  ///It should be one of the ISO ALPHA-2 Code that is provided
  ///in countryList map of countries.dart file.
  final String? initialValue;

  ///This function will be called whenever a Country item is selected.
  final ValueChanged<Country?>? onValuePicked;

  @override
  State<CountryPickerDropdown> createState() => _CountryPickerDropdownState();
}

class _CountryPickerDropdownState extends State<CountryPickerDropdown> {
  late List<Country> _countries;
  Country? _selectedCountry;

  @override
  void initState() {
    _countries =
        countryList.where(widget.itemFilter ?? acceptAllCountries).toList();

    if (widget.initialValue != null) {
      try {
        _selectedCountry = _countries.firstWhere(
              (country) => country.isoCode == widget.initialValue!.toUpperCase(),
        );
      } catch (error) {
        throw Exception(
            "The initialValue provided is not a supported iso code!");
      }
    } else {
      _selectedCountry = _countries[0];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<Country>> items = _countries
        .map((country) => DropdownMenuItem<Country>(
        value: country,
        child: widget.itemBuilder != null
            ? widget.itemBuilder!(country)
            : _buildDefaultMenuItem(country)))
        .toList();

    return Row(
      children: <Widget>[
        DropdownButtonHideUnderline(
          child: DropdownButton<Country>(
            isDense: true,
            onChanged: (value) {
              setState(() {
                _selectedCountry = value;
                widget.onValuePicked!(value);
              });
            },
            items: items,
            value: _selectedCountry,
          ),
        ),
      ],
    );
  }

  Widget _buildDefaultMenuItem(Country country) {
    return Row(
      children: <Widget>[
        CountryPickerUtils.getDefaultFlagImage(country),
        const SizedBox(
          width: 8.0,
        ),
        Text("(${country.isoCode}) +${country.phoneCode}"),
      ],
    );
  }
}


class CountryPickerUtils {
  static Country getCountryByIsoCode(String isoCode) {
    try {
      return countryList.firstWhere(
            (country) => country.isoCode!.toLowerCase() == isoCode.toLowerCase(),
      );
    } catch (error) {
      throw Exception("The initialValue provided is not a supported iso code!");
    }
  }

  static String getFlagImageAssetPath(String isoCode) {
    return "assets/${isoCode.toLowerCase()}.png";
  }

  static Widget getDefaultFlagImage(Country country) {
    return Image.asset(
      CountryPickerUtils.getFlagImageAssetPath(country.isoCode!),
      height: 20.0,
      width: 30.0,
      fit: BoxFit.fill,
      package: "country_currency_pickers",
    );
  }

  static Country getCountryByPhoneCode(String phoneCode) {
    try {
      return countryList.firstWhere(
            (country) => country.phoneCode!.toLowerCase() == phoneCode.toLowerCase(),
      );
    } catch (error) {
      throw Exception(
          "The initialValue provided is not a supported phone code!");
    }
  }

  static Country getCountryByCurrencyCode(String currencyCode) {
    try {
      return countryList.firstWhere(
            (country) =>
        country.currencyCode!.toLowerCase() == currencyCode.toLowerCase(),
      );
    } catch (error) {
      throw Exception(
          "The initialValue provided is not a supported currency code!");
    }
  }
}

class Country {
  final String? name;
  final String? isoCode;
  final String? iso3Code;
  final String? phoneCode;
  final String? currencyCode;
  final String? currencyName;

  Country({
    this.isoCode,
    this.iso3Code,
    this.phoneCode,
    this.name,
    this.currencyCode,
    this.currencyName,
  });

  factory Country.fromMap(Map<String, String> map) => Country(
    name: map['name'],
    isoCode: map['isoCode'],
    iso3Code: map['iso3Code'],
    phoneCode: map['phoneCode'],
    currencyCode: map['currencyCode'],
    currencyName: map['currencyName'],
  );
}



final List<Country> countryList = [
  Country(
      name: "Andorra",
      isoCode: "AD",
      iso3Code: "AND",
      phoneCode: "376",
      currencyCode: "EUR",
      currencyName: "Euro"),
  Country(
      name: "United Arab Emirates",
      isoCode: "AE",
      iso3Code: "ARE",
      phoneCode: "971",
      currencyCode: "AED",
      currencyName: "United Arab Emirates dirham"),
  Country(
      name: "Afghanistan",
      isoCode: "AF",
      iso3Code: "AFG",
      phoneCode: "93",
      currencyCode: "AFN",
      currencyName: "Afghan afghani"),
  Country(
      name: "Antigua and Barbuda",
      isoCode: "AG",
      iso3Code: "ATG",
      phoneCode: "1-268",
      currencyCode: "XCD",
      currencyName: "East Caribbean dollar"),
  Country(
      name: "Anguilla",
      isoCode: "AI",
      iso3Code: "AIA",
      phoneCode: "1-264",
      currencyCode: "XCD",
      currencyName: "East Caribbean dollar"),
  Country(
      name: "Albania",
      isoCode: "AL",
      iso3Code: "ALB",
      phoneCode: "355",
      currencyCode: "ALL",
      currencyName: "Albanian lek"),
  Country(
      name: "Armenia",
      isoCode: "AM",
      iso3Code: "ARM",
      phoneCode: "374",
      currencyCode: "AMD",
      currencyName: "Armenian dram"),
  Country(
      name: "Angola",
      isoCode: "AO",
      iso3Code: "AGO",
      phoneCode: "244",
      currencyCode: "AOA",
      currencyName: "Angolan kwanza"),
  Country(
      name: "Antarctica",
      isoCode: "AQ",
      iso3Code: "ATA",
      phoneCode: "672",
      currencyCode: "AUD",
      currencyName: "Australian dollar"),
  Country(
      name: "Argentina",
      isoCode: "AR",
      iso3Code: "ARG",
      phoneCode: "54",
      currencyCode: "ARS",
      currencyName: "Argentine peso"),
  Country(
      name: "American Samoa",
      isoCode: "AS",
      iso3Code: "ASM",
      phoneCode: "1-684",
      currencyCode: "USD",
      currencyName: "United State Dollar"),
  Country(
      name: "Austria",
      isoCode: "AT",
      iso3Code: "AUT",
      phoneCode: "43",
      currencyCode: "EUR",
      currencyName: "Euro"),
  Country(
      name: "Australia",
      isoCode: "AU",
      iso3Code: "AUS",
      phoneCode: "61",
      currencyCode: "AUD",
      currencyName: "Australian dollar"),
  Country(
      name: "Aruba",
      isoCode: "AW",
      iso3Code: "ABW",
      phoneCode: "297",
      currencyCode: "AWG",
      currencyName: "Aruban florin"),
  Country(
      name: "Åland Islands",
      isoCode: "AX",
      iso3Code: "ALA",
      phoneCode: "358",
      currencyCode: "EUR",
      currencyName: "Euro"),
  Country(
      name: "Azerbaijan",
      isoCode: "AZ",
      iso3Code: "AZE",
      phoneCode: "994",
      currencyCode: "AZN",
      currencyName: "Azerbaijani manat"),
  Country(
      name: "Bosnia and Herzegovina",
      isoCode: "BA",
      iso3Code: "BIH",
      phoneCode: "387",
      currencyCode: "BAM",
      currencyName: "Bosnia and Herzegovina convertible mark"),
  Country(
      name: "Barbados",
      isoCode: "BB",
      iso3Code: "BRB",
      phoneCode: "1-246",
      currencyCode: "BBD",
      currencyName: "Barbadian dollar"),
  Country(
      name: "Bangladesh",
      isoCode: "BD",
      iso3Code: "BGD",
      phoneCode: "880",
      currencyCode: "BDT",
      currencyName: "Bangladeshi taka"),
  Country(
      name: "Belgium",
      isoCode: "BE",
      iso3Code: "BEL",
      phoneCode: "32",
      currencyCode: "EUR",
      currencyName: "Euro"),
  Country(
      name: "Burkina Faso",
      isoCode: "BF",
      iso3Code: "BFA",
      phoneCode: "226",
      currencyCode: "XOF",
      currencyName: "West African CFA franc"),
  Country(
      name: "Bulgaria",
      isoCode: "BG",
      iso3Code: "BGR",
      phoneCode: "359",
      currencyCode: "BGN",
      currencyName: "Bulgarian lev"),
  Country(
      name: "Bahrain",
      isoCode: "BH",
      iso3Code: "BHR",
      phoneCode: "973",
      currencyCode: "BHD",
      currencyName: "Bahraini dinar"),
  Country(
      name: "Burundi",
      isoCode: "BI",
      iso3Code: "BDI",
      phoneCode: "257",
      currencyCode: "BIF",
      currencyName: "Burundian franc"),
  Country(
      name: "Benin",
      isoCode: "BJ",
      iso3Code: "BEN",
      phoneCode: "229",
      currencyCode: "XOF",
      currencyName: "West African CFA franc"),
  Country(
      name: "Saint Barthélemy",
      isoCode: "BL",
      iso3Code: "BLM",
      phoneCode: "590",
      currencyCode: "EUR",
      currencyName: "Euro"),
  Country(
      name: "Bermuda",
      isoCode: "BM",
      iso3Code: "BMU",
      phoneCode: "1-441",
      currencyCode: "BMD",
      currencyName: "Bermudian dollar"),
  Country(
      name: "Brunei Darussalam",
      isoCode: "BN",
      iso3Code: "BRN",
      phoneCode: "673",
      currencyCode: "BND",
      currencyName: "Brunei dollar"),
  Country(
      name: "Bolivia, Plurinational State of",
      isoCode: "BO",
      iso3Code: "BOL",
      phoneCode: "591",
      currencyCode: "BOB",
      currencyName: "Bolivian boliviano"),
  Country(
      name: "Caribbean Netherlands",
      isoCode: "BQ",
      iso3Code: "BES",
      phoneCode: "599",
      currencyCode: "USD",
      currencyName: "United States dollar"),
  Country(
      name: "Brazil",
      isoCode: "BR",
      iso3Code: "BRA",
      phoneCode: "55",
      currencyCode: "BRL",
      currencyName: "Brazilian real"),
  Country(
      name: "Bahamas",
      isoCode: "BS",
      iso3Code: "BHS",
      phoneCode: "1-242",
      currencyCode: "BSD",
      currencyName: "Bahamian dollar"),
  Country(
      name: "Bhutan",
      isoCode: "BT",
      iso3Code: "BTN",
      phoneCode: "975",
      currencyCode: "BTN",
      currencyName: "Bhutanese ngultrum"),
  Country(
      name: "Bouvet Island",
      isoCode: "BV",
      iso3Code: "BVT",
      phoneCode: "47",
      currencyCode: "NOK",
      currencyName: "Norwegian krone"),
  Country(
      name: "Botswana",
      isoCode: "BW",
      iso3Code: "BWA",
      phoneCode: "267",
      currencyCode: "BWP",
      currencyName: "Botswana pula"),
  Country(
      name: "Belarus",
      isoCode: "BY",
      iso3Code: "BLR",
      phoneCode: "375",
      currencyCode: "BYN",
      currencyName: "New Belarusian ruble"),
  Country(
      name: "Belize",
      isoCode: "BZ",
      iso3Code: "BLZ",
      phoneCode: "501",
      currencyCode: "BZD",
      currencyName: "Belize dollar"),
  Country(
      name: "Canada",
      isoCode: "CA",
      iso3Code: "CAN",
      phoneCode: "1",
      currencyCode: "CAD",
      currencyName: "Canadian dollar"),
  Country(
      name: "Cocos (Keeling) Islands",
      isoCode: "CC",
      iso3Code: "CCK",
      phoneCode: "61",
      currencyCode: "AUD",
      currencyName: "Australian dollar"),
  Country(
      name: "Congo, the Democratic Republic of the",
      isoCode: "CD",
      iso3Code: "COD",
      phoneCode: "243",
      currencyCode: "CDF",
      currencyName: "Congolese franc"),
  Country(
      name: "Central African Republic",
      isoCode: "CF",
      iso3Code: "CAF",
      phoneCode: "236",
      currencyCode: "XAF",
      currencyName: "Central African CFA franc"),
  Country(
      name: "Congo",
      isoCode: "CG",
      iso3Code: "COG",
      phoneCode: "242",
      currencyCode: "XAF",
      currencyName: "Central African CFA franc"),
  Country(
      name: "Switzerland",
      isoCode: "CH",
      iso3Code: "CHE",
      phoneCode: "41",
      currencyCode: "CHF",
      currencyName: "Swiss franc"),
  Country(
      name: "Côte d'Ivoire",
      isoCode: "CI",
      iso3Code: "CIV",
      phoneCode: "225",
      currencyCode: "XOF",
      currencyName: "West African CFA franc"),
  Country(
      name: "Cook Islands",
      isoCode: "CK",
      iso3Code: "COK",
      phoneCode: "682",
      currencyCode: "NZD",
      currencyName: "New Zealand dollar"),
  Country(
      name: "Chile",
      isoCode: "CL",
      iso3Code: "CHL",
      phoneCode: "56",
      currencyCode: "CLP",
      currencyName: "Chilean peso"),
  Country(
      name: "Cameroon",
      isoCode: "CM",
      iso3Code: "CMR",
      phoneCode: "237",
      currencyCode: "XAF",
      currencyName: "Central African CFA franc"),
  Country(
      name: "China",
      isoCode: "CN",
      iso3Code: "CHN",
      phoneCode: "86",
      currencyCode: "CNY",
      currencyName: "Chinese yuan"),
  Country(
      name: "Colombia",
      isoCode: "CO",
      iso3Code: "COL",
      phoneCode: "57",
      currencyCode: "COP",
      currencyName: "Colombian peso"),
  Country(
      name: "Costa Rica",
      isoCode: "CR",
      iso3Code: "CRI",
      phoneCode: "506",
      currencyCode: "CRC",
      currencyName: "Costa Rican colón"),
  Country(
      name: "Cuba",
      isoCode: "CU",
      iso3Code: "CUB",
      phoneCode: "53",
      currencyCode: "CUC",
      currencyName: "Cuban convertible peso"),
  Country(
      name: "Cape Verde",
      isoCode: "CV",
      iso3Code: "CPV",
      phoneCode: "238",
      currencyCode: "CVE",
      currencyName: "Cape Verdean escudo"),
  Country(
      name: "Curaçao",
      isoCode: "CW",
      iso3Code: "CUW",
      phoneCode: "599",
      currencyCode: "ANG",
      currencyName: "Netherlands Antillean guilder"),
  Country(
      name: "Christmas Island",
      isoCode: "CX",
      iso3Code: "CXR",
      phoneCode: "61",
      currencyCode: "AUD",
      currencyName: "Australian dollar"),
  Country(
      name: "Cyprus",
      isoCode: "CY",
      iso3Code: "CYP",
      phoneCode: "357",
      currencyCode: "EUR",
      currencyName: "Euro"),
  Country(
      name: "Czech Republic",
      isoCode: "CZ",
      iso3Code: "CZE",
      phoneCode: "420",
      currencyCode: "CZK",
      currencyName: "Czech koruna"),
  Country(
      name: "Germany",
      isoCode: "DE",
      iso3Code: "DEU",
      phoneCode: "49",
      currencyCode: "EUR",
      currencyName: "Euro"),
  Country(
      name: "Djibouti",
      isoCode: "DJ",
      iso3Code: "DJI",
      phoneCode: "253",
      currencyCode: "DJF",
      currencyName: "Djiboutian franc"),
  Country(
      name: "Denmark",
      isoCode: "DK",
      iso3Code: "DNK",
      phoneCode: "45",
      currencyCode: "DKK",
      currencyName: "Danish krone"),
  Country(
      name: "Dominica",
      isoCode: "DM",
      iso3Code: "DMA",
      phoneCode: "1-767",
      currencyCode: "XCD",
      currencyName: "East Caribbean dollar"),
  Country(
      name: "Dominican Republic",
      isoCode: "DO",
      iso3Code: "DOM",
      phoneCode: "1-849",
      currencyCode: "DOP",
      currencyName: "Dominican peso"),
  Country(
      name: "Algeria",
      isoCode: "DZ",
      iso3Code: "DZA",
      phoneCode: "213",
      currencyCode: "DZD",
      currencyName: "Algerian dinar"),
  Country(
      name: "Ecuador",
      isoCode: "EC",
      iso3Code: "ECU",
      phoneCode: "593",
      currencyCode: "USD",
      currencyName: "United States dollar"),
  Country(
      name: "Estonia",
      isoCode: "EE",
      iso3Code: "EST",
      phoneCode: "372",
      currencyCode: "EUR",
      currencyName: "Euro"),
  Country(
      name: "Egypt",
      isoCode: "EG",
      iso3Code: "EGY",
      phoneCode: "20",
      currencyCode: "EGP",
      currencyName: "Egyptian pound"),
  Country(
      name: "Western Sahara",
      isoCode: "EH",
      iso3Code: "ESH",
      phoneCode: "212",
      currencyCode: "MAD",
      currencyName: "Moroccan dirham"),
  Country(
      name: "Eritrea",
      isoCode: "ER",
      iso3Code: "ERI",
      phoneCode: "291",
      currencyCode: "ERN",
      currencyName: "Eritrean nakfa"),
  Country(
      name: "Spain",
      isoCode: "ES",
      iso3Code: "ESP",
      phoneCode: "34",
      currencyCode: "EUR",
      currencyName: "Euro"),
  Country(
      name: "Ethiopia",
      isoCode: "ET",
      iso3Code: "ETH",
      phoneCode: "251",
      currencyCode: "ETB",
      currencyName: "Ethiopian birr"),
  Country(
      name: "Finland",
      isoCode: "FI",
      iso3Code: "FIN",
      phoneCode: "358",
      currencyCode: "EUR",
      currencyName: "Euro"),
  Country(
      name: "Fiji",
      isoCode: "FJ",
      iso3Code: "FJI",
      phoneCode: "679",
      currencyCode: "FJD",
      currencyName: "Fijian dollar"),
  Country(
      name: "Falkland Islands (Malvinas)",
      isoCode: "FK",
      iso3Code: "FLK",
      phoneCode: "500",
      currencyCode: "FKP",
      currencyName: "Falkland Islands pound"),
  Country(
      name: "Micronesia, Federated States of",
      isoCode: "FM",
      iso3Code: "FSM",
      phoneCode: "691",
      currencyCode: "None",
      currencyName: "[D]"),
  Country(
      name: "Faroe Islands",
      isoCode: "FO",
      iso3Code: "FRO",
      phoneCode: "298",
      currencyCode: "DKK",
      currencyName: "Danish krone"),
  Country(
      name: "France",
      isoCode: "FR",
      iso3Code: "FRA",
      phoneCode: "33",
      currencyCode: "EUR",
      currencyName: "Euro"),
  Country(
      name: "Gabon",
      isoCode: "GA",
      iso3Code: "GAB",
      phoneCode: "241",
      currencyCode: "XAF",
      currencyName: "Central African CFA franc"),
  Country(
      name: "United Kingdom",
      isoCode: "GB",
      iso3Code: "GBR",
      phoneCode: "44",
      currencyCode: "GBP",
      currencyName: "British pound"),
  Country(
      name: "Grenada",
      isoCode: "GD",
      iso3Code: "GRD",
      phoneCode: "1-473",
      currencyCode: "XCD",
      currencyName: "East Caribbean dollar"),
  Country(
      name: "Georgia",
      isoCode: "GE",
      iso3Code: "GEO",
      phoneCode: "995",
      currencyCode: "GEL",
      currencyName: "Georgian Lari"),
  Country(
      name: "French Guiana",
      isoCode: "GF",
      iso3Code: "GUF",
      phoneCode: "594",
      currencyCode: "EUR",
      currencyName: "Euro"),
  Country(
      name: "Guernsey",
      isoCode: "GG",
      iso3Code: "GGY",
      phoneCode: "44-1481",
      currencyCode: "GBP",
      currencyName: "British pound"),
  Country(
      name: "Ghana",
      isoCode: "GH",
      iso3Code: "GHA",
      phoneCode: "233",
      currencyCode: "GHS",
      currencyName: "Ghanaian cedi"),
  Country(
      name: "Gibraltar",
      isoCode: "GI",
      iso3Code: "GIB",
      phoneCode: "350",
      currencyCode: "GIP",
      currencyName: "Gibraltar pound"),
  Country(
      name: "Greenland",
      isoCode: "GL",
      iso3Code: "GRL",
      phoneCode: "299",
      currencyCode: "DKK",
      currencyName: "Danish krone"),
  Country(
      name: "Gambia",
      isoCode: "GM",
      iso3Code: "GMB",
      phoneCode: "220",
      currencyCode: "GMD",
      currencyName: "Gambian dalasi"),
  Country(
      name: "Guinea",
      isoCode: "GN",
      iso3Code: "GIN",
      phoneCode: "224",
      currencyCode: "GNF",
      currencyName: "Guinean franc"),
  Country(
      name: "Guadeloupe",
      isoCode: "GP",
      iso3Code: "GLP",
      phoneCode: "590",
      currencyCode: "EUR",
      currencyName: "Euro"),
  Country(
      name: "Equatorial Guinea",
      isoCode: "GQ",
      iso3Code: "GNQ",
      phoneCode: "240",
      currencyCode: "XAF",
      currencyName: "Central African CFA franc"),
  Country(
      name: "Greece",
      isoCode: "GR",
      iso3Code: "GRC",
      phoneCode: "30",
      currencyCode: "EUR",
      currencyName: "Euro"),
  Country(
      name: "South Georgia and the South Sandwich Islands",
      isoCode: "GS",
      iso3Code: "SGS",
      phoneCode: "500",
      currencyCode: "GBP",
      currencyName: "British pound"),
  Country(
      name: "Guatemala",
      isoCode: "GT",
      iso3Code: "GTM",
      phoneCode: "502",
      currencyCode: "GTQ",
      currencyName: "Guatemalan quetzal"),
  Country(
      name: "Guam",
      isoCode: "GU",
      iso3Code: "GUM",
      phoneCode: "1-671",
      currencyCode: "USD",
      currencyName: "United States dollar"),
  Country(
      name: "Guinea-Bissau",
      isoCode: "GW",
      iso3Code: "GNB",
      phoneCode: "245",
      currencyCode: "XOF",
      currencyName: "West African CFA franc"),
  Country(
      name: "Guyana",
      isoCode: "GY",
      iso3Code: "GUY",
      phoneCode: "592",
      currencyCode: "GYD",
      currencyName: "Guyanese dollar"),
  Country(
      name: "Hong Kong",
      isoCode: "HK",
      iso3Code: "HKG",
      phoneCode: "852",
      currencyCode: "HKD",
      currencyName: "Hong Kong dollar"),
  Country(
      name: "Heard Island and McDonald Islands",
      isoCode: "HM",
      iso3Code: "HMD",
      phoneCode: "672",
      currencyCode: "AUD",
      currencyName: "Australian dollar"),
  Country(
      name: "Honduras",
      isoCode: "HN",
      iso3Code: "HND",
      phoneCode: "504",
      currencyCode: "HNL",
      currencyName: "Honduran lempira"),
  Country(
      name: "Croatia",
      isoCode: "HR",
      iso3Code: "HRV",
      phoneCode: "385",
      currencyCode: "HRK",
      currencyName: "Croatian kuna"),
  Country(
      name: "Haiti",
      isoCode: "HT",
      iso3Code: "HTI",
      phoneCode: "509",
      currencyCode: "HTG",
      currencyName: "Haitian gourde"),
  Country(
      name: "Hungary",
      isoCode: "HU",
      iso3Code: "HUN",
      phoneCode: "36",
      currencyCode: "HUF",
      currencyName: "Hungarian forint"),
  Country(
      name: "Indonesia",
      isoCode: "ID",
      iso3Code: "IDN",
      phoneCode: "62",
      currencyCode: "IDR",
      currencyName: "Indonesian rupiah"),
  Country(
      name: "Ireland",
      isoCode: "IE",
      iso3Code: "IRL",
      phoneCode: "353",
      currencyCode: "EUR",
      currencyName: "Euro"),
  Country(
      name: "Israel",
      isoCode: "IL",
      iso3Code: "ISR",
      phoneCode: "972",
      currencyCode: "ILS",
      currencyName: "Israeli new shekel"),
  Country(
      name: "Isle of Man",
      isoCode: "IM",
      iso3Code: "IMN",
      phoneCode: "44-1624",
      currencyCode: "GBP",
      currencyName: "British pound"),
  Country(
      name: "India",
      isoCode: "IN",
      iso3Code: "IND",
      phoneCode: "91",
      currencyCode: "INR",
      currencyName: "Indian rupee"),
  Country(
      name: "British Indian Ocean Territory",
      isoCode: "IO",
      iso3Code: "IOT",
      phoneCode: "246",
      currencyCode: "USD",
      currencyName: "United States dollar"),
  Country(
      name: "Iraq",
      isoCode: "IQ",
      iso3Code: "IRQ",
      phoneCode: "964",
      currencyCode: "IQD",
      currencyName: "Iraqi dinar"),
  Country(
      name: "Iran, Islamic Republic of",
      isoCode: "IR",
      iso3Code: "IRN",
      phoneCode: "98",
      currencyCode: "IRR",
      currencyName: "Iranian rial"),
  Country(
      name: "Iceland",
      isoCode: "IS",
      iso3Code: "ISL",
      phoneCode: "354",
      currencyCode: "ISK",
      currencyName: "Icelandic króna"),
  Country(
      name: "Italy",
      isoCode: "IT",
      iso3Code: "ITA",
      phoneCode: "39",
      currencyCode: "EUR",
      currencyName: "Euro"),
  Country(
      name: "Jersey",
      isoCode: "JE",
      iso3Code: "JEY",
      phoneCode: "44-1534",
      currencyCode: "GBP",
      currencyName: "British pound"),
  Country(
      name: "Jamaica",
      isoCode: "JM",
      iso3Code: "JAM",
      phoneCode: "1-876",
      currencyCode: "JMD",
      currencyName: "Jamaican dollar"),
  Country(
      name: "Jordan",
      isoCode: "JO",
      iso3Code: "JOR",
      phoneCode: "962",
      currencyCode: "JOD",
      currencyName: "Jordanian dinar"),
  Country(
      name: "Japan",
      isoCode: "JP",
      iso3Code: "JPN",
      phoneCode: "81",
      currencyCode: "JPY",
      currencyName: "Japanese yen"),
  Country(
      name: "Kenya",
      isoCode: "KE",
      iso3Code: "KEN",
      phoneCode: "254",
      currencyCode: "KES",
      currencyName: "Kenyan shilling"),
  Country(
      name: "Kyrgyzstan",
      isoCode: "KG",
      iso3Code: "KGZ",
      phoneCode: "996",
      currencyCode: "KGS",
      currencyName: "Kyrgyzstani som"),
  Country(
      name: "Cambodia",
      isoCode: "KH",
      iso3Code: "KHM",
      phoneCode: "855",
      currencyCode: "KHR",
      currencyName: "Cambodian riel"),
  Country(
      name: "Kiribati",
      isoCode: "KI",
      iso3Code: "KIR",
      phoneCode: "686",
      currencyCode: "AUD",
      currencyName: "Australian dollar"),
  Country(
      name: "Comoros",
      isoCode: "KM",
      iso3Code: "COM",
      phoneCode: "269",
      currencyCode: "KMF",
      currencyName: "Comorian franc"),
  Country(
      name: "Saint Kitts and Nevis",
      isoCode: "KN",
      iso3Code: "KNA",
      phoneCode: "1-869",
      currencyCode: "XCD",
      currencyName: "East Caribbean dollar"),
  Country(
      name: "Korea, Democratic People's Republic of",
      isoCode: "KP",
      iso3Code: "PRK",
      phoneCode: "850",
      currencyCode: "KPW",
      currencyName: "North Korean won"),
  Country(
      name: "Korea, Republic of",
      isoCode: "KR",
      iso3Code: "KOR",
      phoneCode: "82",
      currencyCode: "KRW",
      currencyName: "South Korean won"),
  Country(
      name: "Kuwait",
      isoCode: "KW",
      iso3Code: "KWT",
      phoneCode: "965",
      currencyCode: "KWD",
      currencyName: "Kuwaiti dinar"),
  Country(
      name: "Cayman Islands",
      isoCode: "KY",
      iso3Code: "CYM",
      phoneCode: "1-345",
      currencyCode: "KYD",
      currencyName: "Cayman Islands dollar"),
  Country(
      name: "Kazakhstan",
      isoCode: "KZ",
      iso3Code: "KAZ",
      phoneCode: "7",
      currencyCode: "KZT",
      currencyName: "Kazakhstani tenge"),
  Country(
      name: "Lao People's Democratic Republic",
      isoCode: "LA",
      iso3Code: "LAO",
      phoneCode: "",
      currencyCode: "LAK",
      currencyName: "Lao kip"),
  Country(
      name: "Lebanon",
      isoCode: "LB",
      iso3Code: "LBN",
      phoneCode: "961",
      currencyCode: "LBP",
      currencyName: "Lebanese pound"),
  Country(
      name: "Saint Lucia",
      isoCode: "LC",
      iso3Code: "LCA",
      phoneCode: "1-758",
      currencyCode: "XCD",
      currencyName: "East Caribbean dollar"),
  Country(
      name: "Liechtenstein",
      isoCode: "LI",
      iso3Code: "LIE",
      phoneCode: "423",
      currencyCode: "CHF",
      currencyName: "Swiss franc"),
  Country(
      name: "Sri Lanka",
      isoCode: "LK",
      iso3Code: "LKA",
      phoneCode: "94",
      currencyCode: "LKR",
      currencyName: "Sri Lankan rupee"),
  Country(
      name: "Liberia",
      isoCode: "LR",
      iso3Code: "LBR",
      phoneCode: "231",
      currencyCode: "LRD",
      currencyName: "Liberian dollar"),
  Country(
      name: "Lesotho",
      isoCode: "LS",
      iso3Code: "LSO",
      phoneCode: "266",
      currencyCode: "LSL",
      currencyName: "Lesotho loti"),
  Country(
      name: "Lithuania",
      isoCode: "LT",
      iso3Code: "LTU",
      phoneCode: "370",
      currencyCode: "EUR",
      currencyName: "Euro"),
  Country(
      name: "Luxembourg",
      isoCode: "LU",
      iso3Code: "LUX",
      phoneCode: "352",
      currencyCode: "EUR",
      currencyName: "Euro"),
  Country(
      name: "Latvia",
      isoCode: "LV",
      iso3Code: "LVA",
      phoneCode: "371",
      currencyCode: "EUR",
      currencyName: "Euro"),
  Country(
      name: "Libya",
      isoCode: "LY",
      iso3Code: "LBY",
      phoneCode: "218",
      currencyCode: "LYD",
      currencyName: "Libyan dinar"),
  Country(
      name: "Morocco",
      isoCode: "MA",
      iso3Code: "MAR",
      phoneCode: "212",
      currencyCode: "MAD",
      currencyName: "Moroccan dirham"),
  Country(
      name: "Monaco",
      isoCode: "MC",
      iso3Code: "MCO",
      phoneCode: "377",
      currencyCode: "EUR",
      currencyName: "Euro"),
  Country(
      name: "Moldova, Republic of",
      isoCode: "MD",
      iso3Code: "MDA",
      phoneCode: "373",
      currencyCode: "MDL",
      currencyName: "Moldovan leu"),
  Country(
      name: "Montenegro",
      isoCode: "ME",
      iso3Code: "MNE",
      phoneCode: "382",
      currencyCode: "EUR",
      currencyName: "Euro"),
  Country(
      name: "Saint Martin",
      isoCode: "MF",
      iso3Code: "MAF",
      phoneCode: "590",
      currencyCode: "EUR",
      currencyName: "Euro"),
  Country(
      name: "Madagascar",
      isoCode: "MG",
      iso3Code: "MDG",
      phoneCode: "261",
      currencyCode: "MGA",
      currencyName: "Malagasy ariary"),
  Country(
      name: "Marshall Islands",
      isoCode: "MH",
      iso3Code: "MHL",
      phoneCode: "692",
      currencyCode: "USD",
      currencyName: "United States dollar"),
  Country(
      name: "Macedonia, the former Yugoslav Republic of",
      isoCode: "MK",
      iso3Code: "MKD",
      phoneCode: "389",
      currencyCode: "MKD",
      currencyName: "Macedonian denar"),
  Country(
      name: "Mali",
      isoCode: "ML",
      iso3Code: "MLI",
      phoneCode: "223",
      currencyCode: "XOF",
      currencyName: "West African CFA franc"),
  Country(
      name: "Myanmar",
      isoCode: "MM",
      iso3Code: "MMR",
      phoneCode: "95",
      currencyCode: "MMK",
      currencyName: "Burmese kyat"),
  Country(
      name: "Mongolia",
      isoCode: "MN",
      iso3Code: "MNG",
      phoneCode: "976",
      currencyCode: "MNT",
      currencyName: "Mongolian tögrög"),
  Country(
      name: "Macao",
      isoCode: "MO",
      iso3Code: "MAC",
      phoneCode: "853",
      currencyCode: "MOP",
      currencyName: "Macanese pataca"),
  Country(
      name: "Northern Mariana Islands",
      isoCode: "MP",
      iso3Code: "MNP",
      phoneCode: "1-670",
      currencyCode: "USD",
      currencyName: "United States dollar"),
  Country(
      name: "Martinique",
      isoCode: "MQ",
      iso3Code: "MTQ",
      phoneCode: "596",
      currencyCode: "EUR",
      currencyName: "Euro"),
  Country(
      name: "Mauritania",
      isoCode: "MR",
      iso3Code: "MRT",
      phoneCode: "222",
      currencyCode: "MRO",
      currencyName: "Mauritanian ouguiya"),
  Country(
      name: "Montserrat",
      isoCode: "MS",
      iso3Code: "MSR",
      phoneCode: "1-664",
      currencyCode: "XCD",
      currencyName: "East Caribbean dollar"),
  Country(
      name: "Malta",
      isoCode: "MT",
      iso3Code: "MLT",
      phoneCode: "356",
      currencyCode: "EUR",
      currencyName: "Euro"),
  Country(
      name: "Mauritius",
      isoCode: "MU",
      iso3Code: "MUS",
      phoneCode: "230",
      currencyCode: "MUR",
      currencyName: "Mauritian rupee"),
  Country(
      name: "Maldives",
      isoCode: "MV",
      iso3Code: "MDV",
      phoneCode: "960",
      currencyCode: "MVR",
      currencyName: "Maldivian rufiyaa"),
  Country(
      name: "Malawi",
      isoCode: "MW",
      iso3Code: "MWI",
      phoneCode: "265",
      currencyCode: "MWK",
      currencyName: "Malawian kwacha"),
  Country(
      name: "Mexico",
      isoCode: "MX",
      iso3Code: "MEX",
      phoneCode: "52",
      currencyCode: "MXN",
      currencyName: "Mexican peso"),
  Country(
      name: "Malaysia",
      isoCode: "MY",
      iso3Code: "MYS",
      phoneCode: "60",
      currencyCode: "MYR",
      currencyName: "Malaysian ringgit"),
  Country(
      name: "Mozambique",
      isoCode: "MZ",
      iso3Code: "MOZ",
      phoneCode: "258",
      currencyCode: "MZN",
      currencyName: "Mozambican metical"),
  Country(
      name: "Namibia",
      isoCode: "NA",
      iso3Code: "NAM",
      phoneCode: "264",
      currencyCode: "NAD",
      currencyName: "Namibian dollar"),
  Country(
      name: "New Caledonia",
      isoCode: "NC",
      iso3Code: "NCL",
      phoneCode: "687",
      currencyCode: "XPF",
      currencyName: "CFP franc"),
  Country(
      name: "Niger",
      isoCode: "NE",
      iso3Code: "NER",
      phoneCode: "227",
      currencyCode: "XOF",
      currencyName: "West African CFA franc"),
  Country(
      name: "Norfolk Island",
      isoCode: "NF",
      iso3Code: "NFK",
      phoneCode: "672",
      currencyCode: "AUD",
      currencyName: "Australian dollar"),
  Country(
      name: "Nigeria",
      isoCode: "NG",
      iso3Code: "NGA",
      phoneCode: "234",
      currencyCode: "NGN",
      currencyName: "Nigerian naira"),
  Country(
      name: "Nicaragua",
      isoCode: "NI",
      iso3Code: "NIC",
      phoneCode: "505",
      currencyCode: "NIO",
      currencyName: "Nicaraguan córdoba"),
  Country(
      name: "Netherlands",
      isoCode: "NL",
      iso3Code: "NLD",
      phoneCode: "31",
      currencyCode: "EUR",
      currencyName: "Euro"),
  Country(
      name: "Norway",
      isoCode: "NO",
      iso3Code: "NOR",
      phoneCode: "47",
      currencyCode: "NOK",
      currencyName: "Norwegian krone"),
  Country(
      name: "Nepal",
      isoCode: "NP",
      iso3Code: "NPL",
      phoneCode: "977",
      currencyCode: "NPR",
      currencyName: "Nepalese rupee"),
  Country(
      name: "Nauru",
      isoCode: "NR",
      iso3Code: "NRU",
      phoneCode: "674",
      currencyCode: "AUD",
      currencyName: "Australian dollar"),
  Country(
      name: "Niue",
      isoCode: "NU",
      iso3Code: "NIU",
      phoneCode: "683",
      currencyCode: "NZD",
      currencyName: "New Zealand dollar"),
  Country(
      name: "New Zealand",
      isoCode: "NZ",
      iso3Code: "NZL",
      phoneCode: "64",
      currencyCode: "NZD",
      currencyName: "New Zealand dollar"),
  Country(
      name: "Oman",
      isoCode: "OM",
      iso3Code: "OMN",
      phoneCode: "968",
      currencyCode: "OMR",
      currencyName: "Omani rial"),
  Country(
      name: "Panama",
      isoCode: "PA",
      iso3Code: "PAN",
      phoneCode: "507",
      currencyCode: "PAB",
      currencyName: "Panamanian balboa"),
  Country(
      name: "Peru",
      isoCode: "PE",
      iso3Code: "PER",
      phoneCode: "51",
      currencyCode: "PEN",
      currencyName: "Peruvian sol"),
  Country(
      name: "French Polynesia",
      isoCode: "PF",
      iso3Code: "PYF",
      phoneCode: "689",
      currencyCode: "XPF",
      currencyName: "CFP franc"),
  Country(
      name: "Papua New Guinea",
      isoCode: "PG",
      iso3Code: "PNG",
      phoneCode: "675",
      currencyCode: "PGK",
      currencyName: "Papua New Guinean kina"),
  Country(
      name: "Philippines",
      isoCode: "PH",
      iso3Code: "PHL",
      phoneCode: "63",
      currencyCode: "PHP",
      currencyName: "Philippine peso"),
  Country(
      name: "Pakistan",
      isoCode: "PK",
      iso3Code: "PAK",
      phoneCode: "92",
      currencyCode: "PKR",
      currencyName: "Pakistani rupee"),
  Country(
      name: "Poland",
      isoCode: "PL",
      iso3Code: "POL",
      phoneCode: "48",
      currencyCode: "PLN",
      currencyName: "Polish złoty"),
  Country(
      name: "Saint Pierre and Miquelon",
      isoCode: "PM",
      iso3Code: "SPM",
      phoneCode: "508",
      currencyCode: "EUR",
      currencyName: "Euro"),
  Country(
      name: "Pitcairn",
      isoCode: "PN",
      iso3Code: "PCN",
      phoneCode: "64",
      currencyCode: "NZD",
      currencyName: "New Zealand dollar"),
  Country(
      name: "Puerto Rico",
      isoCode: "PR",
      iso3Code: "PRI",
      phoneCode: "1-787",
      currencyCode: "USD",
      currencyName: "United States dollar"),
  Country(
      name: "Palestine",
      isoCode: "PS",
      iso3Code: "PSE",
      phoneCode: "970",
      currencyCode: "ILS",
      currencyName: "Israeli new sheqel"),
  Country(
      name: "Portugal",
      isoCode: "PT",
      iso3Code: "PRT",
      phoneCode: "351",
      currencyCode: "EUR",
      currencyName: "Euro"),
  Country(
      name: "Palau",
      isoCode: "PW",
      iso3Code: "PLW",
      phoneCode: "680",
      currencyCode: "USD",
      currencyName: "United States dollar"),
  Country(
      name: "Paraguay",
      isoCode: "PY",
      iso3Code: "PRY",
      phoneCode: "595",
      currencyCode: "PYG",
      currencyName: "Paraguayan guaraní"),
  Country(
      name: "Qatar",
      isoCode: "QA",
      iso3Code: "QAT",
      phoneCode: "974",
      currencyCode: "QAR",
      currencyName: "Qatari riyal"),
  Country(
      name: "Réunion",
      isoCode: "RE",
      iso3Code: "REU",
      phoneCode: "262",
      currencyCode: "EUR",
      currencyName: "Euro"),
  Country(
      name: "Romania",
      isoCode: "RO",
      iso3Code: "ROU",
      phoneCode: "40",
      currencyCode: "RON",
      currencyName: "Romanian leu"),
  Country(
      name: "Serbia",
      isoCode: "RS",
      iso3Code: "SRB",
      phoneCode: "381",
      currencyCode: "RSD",
      currencyName: "Serbian dinar"),
  Country(
      name: "Russian Federation",
      isoCode: "RU",
      iso3Code: "RUS",
      phoneCode: "7",
      currencyCode: "RUB",
      currencyName: "Russian ruble"),
  Country(
      name: "Rwanda",
      isoCode: "RW",
      iso3Code: "RWA",
      phoneCode: "250",
      currencyCode: "RWF",
      currencyName: "Rwandan franc"),
  Country(
      name: "Saudi Arabia",
      isoCode: "SA",
      iso3Code: "SAU",
      phoneCode: "966",
      currencyCode: "SAR",
      currencyName: "Saudi riyal"),
  Country(
      name: "Solomon Islands",
      isoCode: "SB",
      iso3Code: "SLB",
      phoneCode: "677",
      currencyCode: "SBD",
      currencyName: "Solomon Islands dollar"),
  Country(
      name: "Seychelles",
      isoCode: "SC",
      iso3Code: "SYC",
      phoneCode: "248",
      currencyCode: "SCR",
      currencyName: "Seychellois rupee"),
  Country(
      name: "Sudan",
      isoCode: "SD",
      iso3Code: "SDN",
      phoneCode: "249",
      currencyCode: "SDG",
      currencyName: "Sudanese pound"),
  Country(
      name: "Sweden",
      isoCode: "SE",
      iso3Code: "SWE",
      phoneCode: "46",
      currencyCode: "SEK",
      currencyName: "Swedish krona"),
  Country(
      name: "Singapore",
      isoCode: "SG",
      iso3Code: "SGP",
      phoneCode: "65",
      currencyCode: "SGD",
      currencyName: "Singapore dollar"),
  Country(
      name: "Saint Helena, Ascension and Tristan da Cunha",
      isoCode: "SH",
      iso3Code: "SHN",
      phoneCode: "290",
      currencyCode: "SHP",
      currencyName: "Saint Helena pound"),
  Country(
      name: "Slovenia",
      isoCode: "SI",
      iso3Code: "SVN",
      phoneCode: "386",
      currencyCode: "EUR",
      currencyName: "Euro"),
  Country(
      name: "Svalbard and Jan Mayen Islands",
      isoCode: "SJ",
      iso3Code: "SJM",
      phoneCode: "47",
      currencyCode: "NOK",
      currencyName: "Norwegian krone"),
  Country(
      name: "Slovakia",
      isoCode: "SK",
      iso3Code: "SVK",
      phoneCode: "421",
      currencyCode: "EUR",
      currencyName: "Euro"),
  Country(
      name: "Sierra Leone",
      isoCode: "SL",
      iso3Code: "SLE",
      phoneCode: "232",
      currencyCode: "SLL",
      currencyName: "Sierra Leonean leone"),
  Country(
      name: "San Marino",
      isoCode: "SM",
      iso3Code: "SMR",
      phoneCode: "378",
      currencyCode: "EUR",
      currencyName: "Euro"),
  Country(
      name: "Senegal",
      isoCode: "SN",
      iso3Code: "SEN",
      phoneCode: "221",
      currencyCode: "XOF",
      currencyName: "West African CFA franc"),
  Country(
      name: "Somalia",
      isoCode: "SO",
      iso3Code: "SOM",
      phoneCode: "252",
      currencyCode: "SOS",
      currencyName: "Somali shilling"),
  Country(
      name: "Suriname",
      isoCode: "SR",
      iso3Code: "SUR",
      phoneCode: "597",
      currencyCode: "SRD",
      currencyName: "Surinamese dollar"),
  Country(
      name: "South Sudan",
      isoCode: "SS",
      iso3Code: "SSD",
      phoneCode: "211",
      currencyCode: "SSP",
      currencyName: "South Sudanese pound"),
  Country(
      name: "Sao Tome and Principe",
      isoCode: "ST",
      iso3Code: "STP",
      phoneCode: "239",
      currencyCode: "STD",
      currencyName: "São Tomé and Príncipe dobra"),
  Country(
      name: "El Salvador",
      isoCode: "SV",
      iso3Code: "SLV",
      phoneCode: "503",
      currencyCode: "USD",
      currencyName: "United States dollar"),
  Country(
      name: "Sint Maarten (Dutch part)",
      isoCode: "SX",
      iso3Code: "SXM",
      phoneCode: "1-721",
      currencyCode: "ANG",
      currencyName: "Netherlands Antillean guilder"),
  Country(
      name: "Syrian Arab Republic",
      isoCode: "SY",
      iso3Code: "SYR",
      phoneCode: "963",
      currencyCode: "SYP",
      currencyName: "Syrian pound"),
  Country(
      name: "Swaziland",
      isoCode: "SZ",
      iso3Code: "SWZ",
      phoneCode: "268",
      currencyCode: "SZL",
      currencyName: "Swazi lilangeni"),
  Country(
      name: "Turks and Caicos Islands",
      isoCode: "TC",
      iso3Code: "TCA",
      phoneCode: "1-649",
      currencyCode: "USD",
      currencyName: "United States dollar"),
  Country(
      name: "Chad",
      isoCode: "TD",
      iso3Code: "TCD",
      phoneCode: "235",
      currencyCode: "XAF",
      currencyName: "Central African CFA franc"),
  Country(
      name: "French Southern Territories",
      isoCode: "TF",
      iso3Code: "ATF",
      phoneCode: "262",
      currencyCode: "EUR",
      currencyName: "Euro"),
  Country(
      name: "Togo",
      isoCode: "TG",
      iso3Code: "TGO",
      phoneCode: "228",
      currencyCode: "XOF",
      currencyName: "West African CFA franc"),
  Country(
      name: "Thailand",
      isoCode: "TH",
      iso3Code: "THA",
      phoneCode: "66",
      currencyCode: "THB",
      currencyName: "Thai baht"),
  Country(
      name: "Tajikistan",
      isoCode: "TJ",
      iso3Code: "TJK",
      phoneCode: "992",
      currencyCode: "TJS",
      currencyName: "Tajikistani somoni"),
  Country(
      name: "Tokelau",
      isoCode: "TK",
      iso3Code: "TKL",
      phoneCode: "690",
      currencyCode: "NZD",
      currencyName: "New Zealand dollar"),
  Country(
      name: "Timor-Leste",
      isoCode: "TL",
      iso3Code: "TLS",
      phoneCode: "670",
      currencyCode: "USD",
      currencyName: "United States dollar"),
  Country(
      name: "Turkmenistan",
      isoCode: "TM",
      iso3Code: "TKM",
      phoneCode: "993",
      currencyCode: "TMT",
      currencyName: "Turkmenistan manat"),
  Country(
      name: "Tunisia",
      isoCode: "TN",
      iso3Code: "TUN",
      phoneCode: "216",
      currencyCode: "TND",
      currencyName: "Tunisian dinar"),
  Country(
      name: "Tonga",
      isoCode: "TO",
      iso3Code: "TON",
      phoneCode: "676",
      currencyCode: "TOP",
      currencyName: "Tongan paʻanga"),
  Country(
      name: "Turkey",
      isoCode: "TR",
      iso3Code: "TUR",
      phoneCode: "90",
      currencyCode: "TRY",
      currencyName: "Turkish lira"),
  Country(
      name: "Trinidad and Tobago",
      isoCode: "TT",
      iso3Code: "TTO",
      phoneCode: "1-868",
      currencyCode: "TTD",
      currencyName: "Trinidad and Tobago dollar"),
  Country(
      name: "Tuvalu",
      isoCode: "TV",
      iso3Code: "TUV",
      phoneCode: "688",
      currencyCode: "AUD",
      currencyName: "Australian dollar"),
  Country(
      name: "Taiwan",
      isoCode: "TW",
      iso3Code: "TWN",
      phoneCode: "886",
      currencyCode: "TWD",
      currencyName: "New Taiwan dollar"),
  Country(
      name: "Tanzania, United Republic of",
      isoCode: "TZ",
      iso3Code: "TZA",
      phoneCode: "255",
      currencyCode: "TZS",
      currencyName: "Tanzanian shilling"),
  Country(
      name: "Ukraine",
      isoCode: "UA",
      iso3Code: "UKR",
      phoneCode: "380",
      currencyCode: "UAH",
      currencyName: "Ukrainian hryvnia"),
  Country(
      name: "Uganda",
      isoCode: "UG",
      iso3Code: "UGA",
      phoneCode: "256",
      currencyCode: "UGX",
      currencyName: "Ugandan shilling"),
  Country(
      name: "United States",
      isoCode: "US",
      iso3Code: "USA",
      phoneCode: "1",
      currencyCode: "USD",
      currencyName: "United States dollar"),
  Country(
      name: "Uruguay",
      isoCode: "UY",
      iso3Code: "URY",
      phoneCode: "598",
      currencyCode: "UYU",
      currencyName: "Uruguayan peso"),
  Country(
      name: "Uzbekistan",
      isoCode: "UZ",
      iso3Code: "UZB",
      phoneCode: "998",
      currencyCode: "UZS",
      currencyName: "Uzbekistani so'm"),
  Country(
      name: "Holy See (Vatican City State)",
      isoCode: "VA",
      iso3Code: "VAT",
      phoneCode: "379",
      currencyCode: "EUR",
      currencyName: "Euro"),
  Country(
      name: "Saint Vincent and the Grenadines",
      isoCode: "VC",
      iso3Code: "VCT",
      phoneCode: "1-784",
      currencyCode: "XCD",
      currencyName: "East Caribbean dollar"),
  Country(
      name: "Venezuela, Bolivarian Republic of",
      isoCode: "VE",
      iso3Code: "VEN",
      phoneCode: "58",
      currencyCode: "VEF",
      currencyName: "Venezuelan bolívar"),
  Country(
      name: "Virgin Islands, British",
      isoCode: "VG",
      iso3Code: "VGB",
      phoneCode: "1-284",
      currencyCode: "USD",
      currencyName: "United States dollar"),
  Country(
      name: "Virgin Islands, U.S.",
      isoCode: "VI",
      iso3Code: "VIR",
      phoneCode: "1-340",
      currencyCode: "USD",
      currencyName: "United States dollar"),
  Country(
      name: "Vietnam",
      isoCode: "VN",
      iso3Code: "VNM",
      phoneCode: "84",
      currencyCode: "VND",
      currencyName: "Vietnamese đồng"),
  Country(
      name: "Vanuatu",
      isoCode: "VU",
      iso3Code: "VUT",
      phoneCode: "678",
      currencyCode: "VUV",
      currencyName: "Vanuatu vatu"),
  Country(
      name: "Wallis and Futuna Islands",
      isoCode: "WF",
      iso3Code: "WLF",
      phoneCode: "681",
      currencyCode: "XPF",
      currencyName: "CFP franc"),
  Country(
      name: "Kosovo",
      isoCode: "XK",
      iso3Code: "KOS",
      phoneCode: "383",
      currencyCode: "EUR",
      currencyName: "Euro"),
  Country(
      name: "Samoa",
      isoCode: "WS",
      iso3Code: "WSM",
      phoneCode: "685",
      currencyCode: "WST",
      currencyName: "Samoan tālā"),
  Country(
      name: "Yemen",
      isoCode: "YE",
      iso3Code: "YEM",
      phoneCode: "967",
      currencyCode: "YER",
      currencyName: "Yemeni rial"),
  Country(
      name: "Mayotte",
      isoCode: "YT",
      iso3Code: "MYT",
      phoneCode: "262",
      currencyCode: "EUR",
      currencyName: "Euro"),
  Country(
      name: "South Africa",
      isoCode: "ZA",
      iso3Code: "ZAF",
      phoneCode: "27",
      currencyCode: "ZAR",
      currencyName: "South African rand"),
  Country(
      name: "Zambia",
      isoCode: "ZM",
      iso3Code: "ZMB",
      phoneCode: "260",
      currencyCode: "ZMW",
      currencyName: "Zambian kwacha"),
  Country(
      name: "Zimbabwe",
      isoCode: "ZW",
      iso3Code: "ZWE",
      phoneCode: "263",
      currencyCode: "BWP",
      currencyName: "Botswana pula")
];
