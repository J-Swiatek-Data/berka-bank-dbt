{% macro signed_amount(type_column, amount_column) %}
    case
        when {{ type_column }} = 'credit' then {{ amount_column }}
        else -{{ amount_column }}
    end
{% endmacro %}
